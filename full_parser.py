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

	# lsi_10k example
	print "Parsing Library"
	start = time()
	lsi_lib = PLYPair()
	lsi_lib.set_lexer(ply_liberty.create_lexer())
	lsi_lib.set_parser(ply_liberty.create_parser())
	lsi_lib.parse_file('Examples/lsi_10k.lib')
	total = time() - start
	print "Total Time:", total, "s"
	# import pdb; pdb.set_trace()

	print "Parsing CCX"
	start = time()
	cd = {key : "CELL" for key in lsi_lib.result.keys()}
	ccx = PLYPair()
	ccx.set_lexer(ply_verilog_netlist.create_lexer(cd))
	ccx.set_parser(ply_verilog_netlist.create_parser(lsi_lib.result))
	ccx.parse_file('Examples/ccx_lsi.vSyn')
	total = time() - start
	print "Total Time:", total, "s"
	# print ccx.result
	# import pdb; pdb.set_trace()

	print "Removing Wires from database"
	start = time()
	import wire_remover
	wire_remover.main(ccx.result['wires'], ccx.result['gates'], lsi_lib.result)
	total = time() - start
	print "Total Time:", total, "s"
	
	print "Writing Files"
	start = time()
	import file_writer
	file_writer.out_files(ccx.result['gates'], lsi_lib.result, "test_ccx_ross")
	total = time() - start
	print "Total Time:", total, "s"

	print "Parsing Boolean Expressnions"
	start = time()
	be = PLYPair()
	be.set_lexer(ply_boolean_expressions.create_lexer())
	be.set_parser(ply_boolean_expressions.create_parser())
	error_count = 0
	for g in lsi_lib.result:
		g = lsi_lib.result[g]
		print "*", g.name
		ply_boolean_expressions.update(g.getPinMap())
		for p in g.pin_function:
			if type(g.pin_function[p]) is str:
				func = be.parse(g.pin_function[p])
			else:
				func = g.pin_function[p].generateFuncCall(g.name, p)
				subr = g.pin_function[p].generateFunc(g.name, p)
			# do something with func
			if not func:
				error_count += 1
	print "Total of", error_count, "boolean expression parsing errors"
	total = time() - start
	print "Total Time:", total, "s"

	import pdb; pdb.set_trace()

	ccx.result.stats()
	ccx.result.net_stats()
	ccx.result.wire_stats(lsi_lib.result)

	p = prompt()
	p()



