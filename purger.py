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
g_tokens = {}

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

# PLY LOADING FUNCTIONS
import importlib
def load_library(filename):
	global g_library
	global g_tokens
	if g_library:
		print "Alert: Library", filename, "is already loaded"
		return
	gen_path = path_name(filename)
	if pkl_exists(gen_path+filename):
		print "pkl file exist; loading..."
		g_library = pkl_load(gen_path+filename)
		g_tokens.update(lib_cells(g_library))
	else:
		print "pkl file does not exist; processing"
		mlib = importlib.import_module(ply_default_library)
		plib = PLYPair(mlib.create_lexer(), mlib.create_parser())
		global g_data_path
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
		g_tokens.update(lib_cells(g_library))
		fw = importlib.import_module('file_writer')
		files = fw.modelFiles(gen_path+filename)
		for f in files:
			if os.path.isfile(f):
				print "Error: File", f, "exists"
				return
		stdout = sys.stdout
		sys.stdout = open(gen_path+filename+".errors", "w")
		fw.generateC(gen_path+filename, g_library)
		sys.stdout.close()
		sys.stdout = stdout

def lib_cells(library):
	return {key : "CELL" for key in library.keys()}

def load_netlist_parser():
	global g_netlist_parser
	global g_library
	global g_tokens
	if g_netlist_parser:
		print "Alert: Default netlist parser already loaded"
		return
	mnet = importlib.import_module(ply_default_netlist)
	g_netlist_parser = PLYPair(mnet.create_lexer(g_tokens), mnet.create_parser(g_library))

def load_megacells(filename):
	global g_tokens
	global g_data_path
	mc = load_list(g_data_path+filename)
	for m in mc:
		add_megacell(m+'.v')
		g_tokens[m] = 'MEGACELL'

def load_submodules(module_name):
	global g_tokens
	global g_data_path
	mc = load_list(g_data_path+module_name+'.list')
	if module_name == "mcu":
		tok = "mcu_"
	else:
		tok = ""
	for m in mc:
		add_submodule(module_name+'_'+m+'.vSyn')
		g_tokens[tok+m] = 'SUBMODULE'

def load_defaults():
	load_library("lsi_10k.lib")
	load_megacells("megacell.list")
	# load_netlist_parser()

def remove_wires(all_wires, all_gates, gate_types):
	import classes
	error_count = 0
	error_names = []
	processed_list = []
	for w in all_wires:
		# import pdb; pdb.set_trace()
		# all_wires[w] is a list of gate objects
		inputs = 0
		inref = ""
		outputs = 0
		# note that we want 1 output to a wire (from a gate)
		#	which can lead to many inputs (to gates)
		if 'multibit_flag' in all_wires[w]:
			processed_list.append(w)
			continue
		my_gates = list(set(all_wires[w]))
		for g in my_gates:
			d = g.getRefDirectionCounts(w)
			inputs += d[0]
			outputs+= d[1]
			if d[1] >= 1:
				inref = g
		if len(all_wires[w]) < inputs+outputs:
			print "ERROR(w1): wire", w, "has wrong input+output count", input+output,"!=", all_wires[w]
		if inputs == 0 and outputs == 0:
			# unused wire
			processed_list.append(w)
			continue
		elif inputs == 0:
			# wire goes nowhere
			# print "ERROR(w2a): wire", w, "goes nowhere"
			error_count += 1
			error_names.append(w)
			processed_list.append(w)
			continue
		elif outputs == 0:
			# wire comes from nowhere
			# print "ERROR(w2b): wire", w, "comes from nowhere"
			error_count += 1
			error_names.append(w)
			processed_list.append(w)
			continue
		elif outputs != 1:
			# wire comes too many places
			# FANIN
			print "ERROR(w2c): FANIN on wire", w
			error_count += 1
			error_names.append(w)
			processed_list.append(w)
			continue
		elif inputs > 1:
			# print "WARNING: wire", w, "has fannout", outputs
			fan = classes.Gate(w)
			fan.setType(gate_types["fanout"])
			fan.addRef("in", inref)
			for g in my_gates:
				if isinstance(g, classes.Gate):
					if g.isInput(w):
						fan.addFanOut(g)
					g.updateRef(w, fan)
			all_gates[fan.name] = fan
		else: # outputs = 1, inputs = 1
			g0 = all_wires[w][0]
			g1 = all_wires[w][1]
			g0.updateRef(w, g1)
			g1.updateRef(w, g0)
		processed_list.append(w)
	if len(processed_list) != len(all_wires.keys()):
		print "ALERT: SOMETHING STRANGE HAPPENED", len(processed_list), "!=", len(all_wires.keys())
	print "Total of", error_count, "wire errors"
	# gate checker
	error_count = 0
	for g in all_gates:
		g = all_gates[g]
		for j in g.pin_ref:
			k = g.pin_ref[j]
			if k and type(k) is str and (k not in g.type.multibits) and (g.type.name.find("put_gate") == -1):
				if k in error_names or k.find('#') == 0:
					# print "ALERT: Gate", g.name, "has a known weird reference on wire", k
					pass
				else:
					if k in all_wires:
						if k in processed_list:
							print "ERROR(w4c): Gate", g.name, "references pop'd wire", k
						else:
							print "ERROR(w4a): Gate", g.name, "references known wire", k
					else:
						print "ERROR(w4b): Gate", g.name, "references unknown wire", k
				error_count += 1
	print "Total of", error_count, "gate errors"

def parse_netlist(netlist_name):
	result = None
	gen_path = path_name(netlist_name)
	if pkl_exists(gen_path+netlist_name):
		print "pkl file exists; loading..."
		result = pkl_load(gen_path+netlist_name)
	else:
		print "pkl file does not exist; processing..."
		global g_netlist_parser
		global g_data_path
		result = g_netlist_parser.parse_file(g_data_path+netlist_name)
		global g_library
		stdout = sys.stdout
		sys.stdout = open(gen_path+netlist_name+".errors", 'w')
		remove_wires(result['wires'], result['gates'], g_library)
		sys.stdout.close()
		sys.stdout = stdout
		fw = importlib.import_module('file_writer')
		fw.generateRoss(gen_path+netlist_name, g_library, result['gates'])
		fw.generateConnections(gen_path+netlist_name, result['gates'])
		# pkl_dump(fullname, result['obj']) ## ???
	return result

def add_submodule(modfile):
	gen_path = path_name(modfile)
	if pkl_exists(gen_path+modfile):
		h = pkl_load(gen_path+modfile)
	else:
		print modfile, "pkl does nto exist, parsing input/output files..."
		h = {}
		dirs = ["input", "output"]
		for d in dirs:
			f = open(gen_path+modfile+"."+d,'r')
			for line in f:
				line = line.strip().split(' ')
				h[line[1]] = (int(line[0]), d)
			f.close()
		f = open(gen_path+modfile+".multibit",'r')
		for line in f:
			line = line.strip().split(' ')
			h[line[0]] = ['multibit_flag', line[1:]]
		f.close()
		pkl_dump(gen_path+modfile, h)
	import classes
	mod_name = modfile.split('.')[0]
	classes.submodule_map[mod_name] = h

def add_megacell(cellfile):
	# must be called AFTER netlist parser is initiated (with cells)
	gen_path = path_name(cellfile, True)
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

def load_list(filename, suffix=''):
	r = []
	f = open(filename, 'r')
	for line in f:
		r.append(line.strip()+suffix)
	f.close()
	return r

def purger_help():
	print "Welcome to PURGER:"
	print "Parser-Unified ROSS Gates Emission Routine"
	print ""
	print "Available commands:"
	print "\tpurger_help()\t\t\t\tShow this help text"
	print "\tlib  = load_library(lib_name)\t\tLoad a library using", ply_default_library, "and", ply_default_boolexp
	print "\tadd_megacell(cellfile_name)\t\tAdd a megacell definition to library (must load library first)"
	print "\tnetp = load_netlist_parser(lib)\t\tLoad a netlist parser using", ply_default_netlist
	print "\tload_defaults()\t\t\t\tInit the default library and load default netlist parser"
	print "\tnet  = parse_netlist(netlist_name)\tProcess a netlist using", ply_default_netlist

import sys
if __name__ == "__main__":
	if not sys.flags.interactive:
		print "Load PURGER functions into an interactive python shell:"
		print "$ python -i", sys.argv[0]
	else:
		print "Find out more about PURGER with the command"
		print "> purger_help()"
