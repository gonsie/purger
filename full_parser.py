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

def main(flib, fnet, targetdir="current/"):

	import ply_liberty
	print "\nParsing Library"
	start = time()
	lsi_lib = PLYPair()
	lsi_lib.set_lexer(ply_liberty.create_lexer())
	lsi_lib.set_parser(ply_liberty.create_parser())
	lsi_lib.parse_file(flib)
	total = time() - start
	print "Total Time:", total, "s"
	# import pdb; pdb.set_trace()

	import ply_boolean_expressions
	print "\nParsing Boolean Expressions"
	start = time()
	be = PLYPair()
	be.set_lexer(ply_boolean_expressions.create_lexer())
	be.set_parser(ply_boolean_expressions.create_parser())
	error_count = 0
	for g in lsi_lib.result:
		g = lsi_lib.result[g]
		ply_boolean_expressions.update(g.getPinMap())
		for p in g.pins:
			if 'function' in g.pins[p]:
				g.pins[p]['o_function'] = g.pins[p]['function']
				g.pins[p]['function'] = be.parse(g.pins[p]['function'])
		for s in g.specials:
			s = g.specials[s]
			for k in s.getBEatts():
				s.atts['o_'+k] = s.atts[k]
				s.atts[k] = be.parse(s.atts[k])
	print "Total of", error_count, "boolean expression parsing errors"
	total = time() - start
	print "Total Time:", total, "s"
	# import pdb; pdb.set_trace()

	import ply_verilog_netlist
	print "\nParsing CCX"
	start = time()
	cd = {key : "CELL" for key in lsi_lib.result.keys()}
	ccx = PLYPair()
	ccx.set_lexer(ply_verilog_netlist.create_lexer(cd))
	ccx.set_parser(ply_verilog_netlist.create_parser(lsi_lib.result))
	ccx.parse_file(fnet)
	total = time() - start
	print "Total Time:", total, "s"
	# import pdb; pdb.set_trace()

	import wire_remover
	print "\nRemoving Wires from database"
	start = time()
	wire_remover.main(ccx.result['wires'], ccx.result['gates'], lsi_lib.result)
	total = time() - start
	print "Total Time:", total, "s"
	# import pdb; pdb.set_trace()

	import file_writer
	print "\nWriting Files"
	start = time()
	flib = flib.split('/')[-1].split('.')[0]
	fnet = fnet.split('/')[-1].split('.')[0]
	file_writer.generateC(targetdir+flib, lsi_lib.result)
	file_writer.generateRoss(targetdir+fnet, lsi_lib.result, ccx.result['gates'])
	total = time() - start
	print "Total Time:", total, "s"

	import pdb; pdb.set_trace()

from time import time
import sys

if __name__ == "__main__":
	if len(sys.argv) < 3:
		print "Usage:", sys.argv[0], "library_file netlist_file"
	else:
		main(sys.argv[1], sys.argv[2])
