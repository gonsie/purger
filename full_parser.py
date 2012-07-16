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

	def parse(self, fname):
		f = open(fname, 'r')
		a = f.read()
		f.close()
		self.result = self.parser.parse(a, lexer=self.lexer)
		return self.result

import ply_verilog_netlist
import ply_liberty
import ply_boolean_expressions

if __name__ == "__main__":
	print "\n*** Liberty Parser"
	l = PLYPair()
	l.set_lexer(ply_liberty.create_lexer())
	l.set_parser(ply_liberty.create_parser())
	l.parse('Examples/example_library.lib')
	cd = l.result.cell_dict()
	pd = l.result.pin_dict('AND2')
	pm = l.result.pin_map('AND2')

	print "\n*** Verilog Netlist Parser"
	vn = PLYPair()
	vn.set_lexer(ply_verilog_netlist.create_lexer(cd))
	vn.set_parser(ply_verilog_netlist.create_parser())
	vn.parse('Examples/example_netlist.v')

	print "\n*** Boolean Expression Parser"
	be = PLYPair()
	be.set_lexer(ply_boolean_expressions.create_lexer(pd, pm))
	be.set_parser(ply_boolean_expressions.create_parser())
	be.parse('Examples/example_boolexp.txt')


