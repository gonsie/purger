#!/usr/bin/python

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

import ply_verilog_netlist
import ply_liberty
import ply_boolean_expressions
from time import time
import os

def prompt(vars=None):
    prompt_message = "Brama Front End"
    try:
        from IPython.Shell import IPShellEmbed
        ipshell = IPShellEmbed(argv=[''],banner=prompt_message,exit_msg="Goodbye")
        return  ipshell
    except ImportError:
        if vars is None:  vars=globals()
        import code
        import rlcompleter
        import readline
        readline.parse_and_bind("tab: complete")
        # calling this with globals ensures we can see the environment
        print prompt_message
        shell = code.InteractiveConsole(vars)
        return shell.interact

def dict_stats(d):
	total = 0
	max_len = 0
	for k in d:
		total += len(d[k])
		max_len = max(max_len, len(d[k]))
	print "Average Length =", total, "/", len(d), "=", total / float(len(d))
	print "Max = ", max_len


if __name__ == "__main__":

	# create the database
	dbname = 'test.db'
	if os.path.exists(dbname): os.remove(dbname)

	# lsi_10k example
	print "Parsing Library"
	lsi_lib = PLYPair()
	lsi_lib.set_lexer(ply_liberty.create_lexer())
	lsi_lib.set_parser(ply_liberty.create_parser(dbname))
	lsi_lib.parse_file('Examples/lsi_10k.lib')
	# print lsi_lib.result['sql']
	# print lsi_lib.result['cells']

	print "Parsing CCX"
	cd = lsi_lib.result['cells']
	ccx = PLYPair()
	ccx.set_lexer(ply_verilog_netlist.create_lexer(cd))
	ccx.set_parser(ply_verilog_netlist.create_parser(dbname))
	start = time()
	ccx.parse_file('Examples/ccx_lsi.vSyn')
	total = time() - start
	print "Total Time:", total, "s"
	# print ccx.result
	# import pdb; pdb.set_trace()

	print "Removing Wires from database"
	start = time()
	import wire_remover
	wire_remover.main(dbname, ccx.result['wires'], ccx.result['gates'], lsi_lib.result['pins'])
	total = time() - start
	print "Total Time:", total, "s"

	ccx.result.stats()
	ccx.result.net_stats()
	ccx.result.wire_stats(lsi_lib.result)

	p = prompt()
	p()



