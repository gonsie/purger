#!/usr/bin/python

# Elsa Gonsiorowski
# August 26, 2015

## GLOBAL NAMES / default values
ply_default_library = "ply_liberty"
ply_default_boolexp = "ply_boolean_expressions"
ply_default_netlist = "ply_verilog_netlist"
ply_default_rtl = "ply_verilog_rtl"

## GLOBAL VARIABLE
g_library = None
g_netlist_parser = None

## FILE SYSTEM SETTINGS
g_data_path = "Data/"
g_data_netlist_file_type = ".vSyn"
g_data_rtl_file_type = ".v"
g_generated_path = "Generated/"

# Encapsulation of lexer/parser pair
class PLYPair:
	def __init__(self, l=None, p=None):
		self.lexer = l
		self.parser = p
		self.result = None

	def set_lexer(self, l):
		self.lexer = l

	def set_parser(self, p):
		self.parser = p

	def parse_file(self, fname):
		f = open(fname, 'r')
		a = f.read()
		f.close()
		return self.parse(a)

	def parse(self, text):
		self.result = self.parser.parse(text, lexer=self.lexer)
		return self.result

# OS and PKL FUNCTIONS
def path_name(filename, megacell=False):
	global g_generated_path
	name = filename.split('.')[0]
	if megacell:
		return g_generated_path+"megacell"+'/'
	return g_generated_path+name+'/'

import os.path
def pkl_exists(name):
	return os.path.isfile(name+'.pkl')

import cPickle
def pkl_load(name):
	f = open(name+'.pkl', 'rb')
	result = cPickle.load(f)
	f.close()
	return result

def pkl_dump(name, result):
	f = open(name+'.pkl','wb')
	try:
		cPickle.dump(result, f)
		f.close()
	except RuntimeError, e:
		print "Could not pkl", name, e
		f.close()
		os.remove(name+'.pkl')

import importlib
def load_library(filename):
	global g_library
	if g_library:
		print "Alert: Library", filename, "is already loaded"
		return
	gen_path = path_name(filename)
	if pkl_exists(gen_path+filename):
		print "pkl file exist; loading..."
		g_library = pkl_load(gen_path+filename)
	else:
		print "pkl file does not exist; processing"
		mlib = importlib.import_module(ply_default_library)
		plib = PLYPair(mlib.create_lexer(), mlib.create_parser())
		g_library = plib.parse_file(g_data_path+filename)
		# boolean expressions
		mbxp = importlib.import_module(ply_default_boolexp)
		pbxp = PLYPair(mbxp.create_lexer(), mbxp.create_parser())
		for g in g_library:
			g = g_library[g]
			mbxp.update(g.getPinMap())
			for p in g.pins:
				if 'function' in g.pins[p]:
					g.pins[p]['o_function'] = g.pins[p]['function']
					g.pins[p]['function'] = pbxp.parse(g.pins[p]['function'])
			for s in g.specials:
				s = g.specials[s]
				for k in s.getBEatts():
					s.atts['o_'+k] = s.atts[k]
					s.atts[k] = pbxp.parse(s.atts[k])
		pkl_dump(gen_path+filename, g_library)

def lib_cells(library):
	return {key : "CELL" for key in library.keys()}

def load_netlist_parser(library):
	global g_netlist_parser
	if g_netlist_parser:
		print "Alert: Default netlist parser already loaded"
		return
	mnet = importlib.import_module(ply_default_netlist)
	g_netlist_parser = PLYPair(mnet.create_lexer(lib_cells(library)), mnet.create_parser(library))

def load_defaults():
	load_library("lsi_10k.lib")
	global g_library
	load_netlist_parser(g_library)

def remove_wires(all_wires, all_gates, gate_types):
	import classes
	error_count = 0
	error_names = []
	pop_list = []
	for w in all_wires:
		# import pdb; pdb.set_trace()
		# all_wires[w] is a list of gate objects
		inputs = 0
		inref = ""
		outputs = 0
		# note that we want 1 output to a wire (from a gate)
		#	which can lead to many inputs (to gates)
		for g in all_wires[w]:
			if not isinstance(g, classes.Gate):
				print "Error(w0): could not remove wires from object", g, "of type", type(g)
				continue
			d = g.getRefDirection(w)
			if d == "input":
				inputs += 1
			elif d == "output":
				outputs += 1
				inref = g
			else:
				print "ERROR(w1): pin with direction", d, "for wire", w
		if inputs == 0 and outputs == 0:
			pop_list.append(w)
			continue
		if inputs == 0 or outputs != 1:
			print "ERROR(w2): wrong number of inputs (", inputs, ") or outputs (", outputs, ") on wire", w
			error_count += 1
			error_names.append(w)
			continue
		if inputs > 1:
			# print "WARNING: wire", w, "has fannout", outputs
			fan = classes.Gate(w)
			fan.setType(gate_types["fanout"])
			for g in all_wires[w]:
				if isinstance(g, classes.Gate):
					if g.getRefDirection(w) is "output":
						fan.addRef("in", inref)
					else:
						fan.addFanOut(g)
					g.updateRef(w, fan)
			all_gates[fan.name] = fan
		else: # outputs = 1, inputs = 1
			g0 = all_wires[w][0]
			g1 = all_wires[w][1]
			g0.updateRef(w, g1)
			g1.updateRef(w, g0)
	for w in pop_list:
		all_wires.pop(w)
	print "Total of", error_count, "wire errors"
	# gate checker
	error_count = 0
	for g in all_gates:
		g = all_gates[g]
		for k in g.ref_pin:
			if type(k) is str and g.type.name.find("put_gate") == -1:
				print "ERROR(w4): Gate", g.name, "references wire", k
				error_count += 1
	print "Total of", error_count, "gate errors"

def parse_netlist(netlist_name):
	result = None
	if pkl_exists(fullname):
		print "pkl file exists; loading..."
		result = pkl_load(fullname)
	else:
		print "pkl file does not exist; processing..."
		global g_netlist_parser
		result = g_netlist_parser.parse_file(netlist_name)
		global g_library
		stdout = sys.stdout
		sys.stdout = open(netlist_name+"_errors.txt", 'w')
		remove_wires(result['wires'], result['gates'], g_library)
		sys.stdout.close()
		sys.stdout = stdout
		# pkl_dump(fullname, result['obj']) ## ???
	return result

def write_model(prefix=""):
	import file_writer
	global g_library
	global g_libname
	if not g_library:
		print "Error: no library is loaded"
	files = file_writer.modelFiles(prefix+g_libname)
	for f in files:
		if os.path.isfile(f):
			print "Error: File", f, "exists"
			return
	stdout = sys.stdout
	sys.stdout = open(prefix+g_libname+"_errors.txt", "w")
	file_writer.generateC(prefix+g_libname, g_library)
	sys.stdout.close()
	sys.stdout = stdout

def write_module(name, netlist):
	import file_writer
	global g_library
	# files = file_writer.instanceFiles(name, number)
	# for f in files:
	# 	if os.path.isfile(f):
	# 		print "Error: File", f, "exists"
	# 		return
	file_writer.generateRoss(name, g_library, netlist['gates'])
	file_writer.generateConnections(name, netlist['gates'])

def parse_loop(name_list):
	load_defaults()
	print name_list
	for y in name_list:
		print "Parsing", y
		net = parse_netlist(y+'.vSyn')
		print "Writing", y
		write_module("../Generated/"+y, net)

def add_megacell(cellfile):
	# must be called AFTER netlist parser is initiated (with cells)
	gen_path = path_name(cellfile)
	if pkl_exists(gen_path+cellfile):
		print "pkl file exists, loading..."
		h = pkl_load(gen_path+cellfile)
	else:
		print "pkl file does not exist, parsing rtl file..."
		global ply_default_rtl
		rlib = importlib.import_module(ply_default_rtl)
		r = PLYPair(rlib.create_lexer(), rlib.create_parser())
		global g_data_path
		h = r.parse_file(g_data_path+cellfile)[0]
		pkl_dump(gen_path+cellfile, h)
	global g_library
	cellname = cellfile.split('.')[0]
	g_library[cellname] = h

def purger_help():
	print "Welcome to PURGER:"
	print "Parser-Unified ROSS Gates Emission Routine"
	print ""
	print "Available commands:"
	print "\tpurger_help()\t\t\t\tShow this help text"
	print "\tlib  = load_library(lib_name)\t\tLoad a library using", ply_default_library, "and", ply_default_boolexp
	print "\tnetp = load_netlist_parser(lib)\t\tLoad a netlist parser using", ply_default_netlist
	print "\tload_defaults()\t\t\t\tInit the default library and load default netlist parser"
	print "\tnet  = parse_netlist(netlist_name)\tProcess a netlist using", ply_default_netlist
	print "\twrite_model(\"prefix\")\t\t\tGenerate the library gate model"
	print "\twrite_module(\"prefix/name\", net)\tGenerate the ROSS init file and connection files"

import sys
if __name__ == "__main__":
	if not sys.flags.interactive:
		print "Load PURGER functions into an interactive python shell:"
		print "$ python -i", sys.argv[0]
	else:
		print "Find out more about PURGER with the command"
		print "> purger_help()"
