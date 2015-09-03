#!/usr/bin/python

# Elsa Gonsiorowski
# August 26, 2015

## GLOBAL NAMES / default values
ply_default_library = "ply_liberty"
ply_default_boolexp = "ply_boolean_expressions"
ply_default_netlist = "ply_verilog_netlist"

## GLOBAL VARIABLE
g_library = None
g_libname = None
g_netlist_parser = None

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

import os.path
def pkl_name(plyname, filename):
	fname = os.path.basename(filename)
	return plyname+'-parsed-'+fname+'.pkl'

def pkl_exists(fullname):
	return os.path.isfile(fullname)

import cPickle
def pkl_load(fullname):
	f = open(fullname, 'rb')
	result = cPickle.load(f)
	f.close()
	return result

def pkl_dump(fullname, result):
	f = open(fullname,'wb')
	cPickle.dump(result, f)
	f.close()

import importlib
def load_library(lib_name):
	global g_library
	global g_libname
	if g_library:
		print "Alert: Library", g_libname, "is already loaded"
		return
	fullname = pkl_name(ply_default_library, lib_name)
	if pkl_exists(fullname):
		print "pkl file exist; loading..."
		g_library = pkl_load(fullname)
		g_libname = lib_name.split("/")[-1].split(".")[0]
	else:
		print "pkl file does not exist; processing"
		mlib = importlib.import_module(ply_default_library)
		plib = PLYPair(mlib.create_lexer(), mlib.create_parser())
		g_library = plib.parse_file(lib_name)
		g_libname = lib_name.split("/")[-1].split(".")[0]
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
		pkl_dump(fullname, g_library)

def lib_cells(library):
	return {key : "CELL" for key in library.keys()}

def load_defaults():
	load_library("lsi_10k.lib")
	global g_library
	load_netlist_parser(g_library)

def load_netlist_parser(library):
	global g_netlist_parser
	if g_netlist_parser:
		print "Alert: Default netlist parser already loaded"
		return
	mnet = importlib.import_module(ply_default_netlist)
	g_netlist_parser = PLYPair(mnet.create_lexer(lib_cells(library)), mnet.create_parser(library))

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
		if inputs == 0 or outputs == 0 or outputs > 1:
			print "ERROR(w2): wrong number of inputs (", inputs, ") or outputs (", outputs, ") on wire", w
			error_count += 1
			error_names.append(w)
			continue
		if inputs > 1:
			# print "WARNING: wire", w, "has fannout", outputs
			fan = classes.Gate(w)
			fan.setType(gate_types["fanout"])
			for g in all_wires[w]:
				if g.getRefDirection(w) is "output":
					fan.addRef("in", inref)
				else:
					fan.addFanOut(g)
				g.updateRef(w, fan)
			all_gates[fan.name] = fan
		else:
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
	fullname = pkl_name(ply_default_netlist+'-'+ply_default_library, netlist_name)
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
		pkl_dump(fullname, result)
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

def purger_help():
	print "Welcome to PURGER:"
	print "Parser-Unified ROSS Gates Emission Routine"
	print ""
	print "Available commands:"
	print "\tpurger_help()\t\t\t\tShow this help text"
	print "\tlib  = load_library(lib_name)\t\tLoad a library using", ply_default_library, "and", ply_default_boolexp
	print "\tnetp = load_netlist_parser(lib)\t\tLoad a netlist parser using", ply_default_netlist
	print "\tload_defaults()\t\t\t\tInit the default library and load default netlist parser"
	print "\tnet  = process_netlist(netlist_name)\tProcess a netlist using", ply_default_netlist
	print "\twrite_model(\"prefix\")\t\t\tGenerate the library gate model"
	print "\twrite_module(\"prefix/name\", net)\tGenerate the ROSS init file and connection files"

import sys
if __name__ == "__main__":
	print "Load PURGER functions into an interactive python shell:"
	print "$ python -i", sys.argv[0]
	print ""
	print "Find out more about PURGER with the command"
	print "> purger_help()"
