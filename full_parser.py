# Encapsulation of lexer/parser pair
class PLYPair:
	def __init__(self, l=None, p=None):
		self.lexer = l
		self.parser = p

	def set_lexer(self, l):
		self.lexer = l

	def set_parser(self, p):
		self.parser = p

	def parse(self, fname):
		f = open(fname, 'r')
		a = f.read()
		f.close()

		return self.parser.parse(a, lexer=self.lexer)

import verilog_netlist

if __name__ == "__main__":
		vn = PLYPair()
		vn.set_lexer(verilog_netlist.create_lexer({'and':'CELL','or':'CELL'}))
		vn.set_parser(verilog_netlist.create_parser())
		vn.parse('Examples/example_netlist.v')


