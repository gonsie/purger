#!/usr/bin/python

# Elsa Gonsiorowski
# August 26, 2015

## GLOBAL NAMES / default values
ply_default_library = "ply_liberty"
ply_default_boolexp = "ply_boolean_expressions"
ply_default_netlist = "ply_verilog_netlist"

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
	fullname = pkl_name(ply_default_library, lib_name)
	result = None
	if pkl_exists(fullname):
		print "pkl file exist; loading..."
		result = pkl_load(fullname)
	else:
		print "pkl file does not exist; processing"
		mlib = importlib.import_module(ply_default_library)
		plib = PLYPair(mlib.create_lexer(), mlib.create_parser())
		result = plib.parse_file(lib_name)
		# boolean expressions
		mbxp = importlib.import_module(ply_default_boolexp)
		pbxp = PLYPair(mbxp.create_lexer(), mbxp.create_parser())
		for g in result:
			g = result[g]
			m.update(g.getPinMap())
			for p in g.pins:
				if 'function' in g.pins[p]:
					g.pins[p]['o_function'] = g.pins[p]['function']
					g.pins[p]['function'] = pbxp.parse(g.pins[p]['function'])
			for s in g.specials:
				s = g.specials[s]
				for k in s.getBEatts():
					s.atts['o_'+k] = s.atts[k]
					s.atts[k] = pbxp.parse(s.atts[k])
		pkl_dump(fullname, result)
	return result

def lib_cells(library):
	return {key : "CELL" for key in library.keys()}

def process_netlist(netlist_name, library):
	fullname = pkl_name(ply_default_netlist+'-'+ply_default_library, netlist_name)
	result = None
	if pkl_exists(fullname):
		print "pkl file exists; loading..."
		result = pkl_load(fullname)
	else:
		print "pkl file does not exist; processing..."
		mnet = importlib.import_module(ply_default_netlist)
		pnet = PLYPair(mnet.create_lexer(lib_cells(library)), mnet.create_parser(library))
		result = pp.parse(netlist_name)
		import wire_remover
		wire_remover.main(result['wires'], result['gates'], library)
	return result

def purger_help():
	print ""
	print "Welcome to PURGER:"
	print "Parser-Unified ROSS Gates Emission Routine"
	print ""
	print "Available commands:"
	print "\tpurger_help()\t\t\tShow this help text"
	print "\tload_library(lib_name)\t\tLoad a library using", ply_default_library, "and", ply_default_boolexp
	print "\tprocess_netlist(netlist_name)\tProcess a netlist using", ply_default_netlist
	print "\tsomething_else?????"

import sys
if __name__ == "__main__":
	print "Load PURGER functions into an interactive python shell:"
	print "$ python -i", sys.argv[0]
	print ""
	print "Find out more about PURGER with the command"
	print "> purger_help()"
