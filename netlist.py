# Module
# - [ Item ]
# 	- ( type, Wire ) (input, output, wire)
# 	- { Wire : Wire } (assign)
# 	- Net
#		- [ { Port : Wire } ]


class Module:
	def __init__(self, name, list_of_ports, module_items):
		self.name = name
		self.ports = list_of_ports
		self.inputs = []
		self.outputs = []
		self.wires = []
		self.assigns = []
		self.nets = []
		for item in module_items:
			if type(item) is tuple:
				if item[0] == 'input':
					self.inputs.append(item[1])
				elif item[0] == 'output':
					self.outputs.append(item[1])
				elif item[0] == 'wire':
					self.wires.append(item[1])
				else:
					print "ERROR: unrecognized type", item[0]
			elif type(item) is dict:
				self.assigns.append(item)
			else:
				self.nets.append(item)

	def __repr__(self):
		return self.name

	def stats(self):
		print "Module", self.name
		print "\t", len(self.ports), "ports"
		print "\t", len(self.inputs), "inputs"
		print "\t", len(self.outputs), "outputs"
		print "\t", len(self.wires), "wires"
		print "\t", len(self.assigns), "assigns"
		print "\t", len(self.nets), "nets"

class Item:
	def __init__(self, t, w):
		self.type = t
		self.wire = w

	def add_value(self, v):
		if self.type != 'ASSIGN':
			print "WARNING: adding value to a non-ASSIGN item"
		self.value = v

class Net:
	def __init__(self, name, connections):
		self.name = name
		self.connections = connections

	def __repr__(self):
		return self.name

	def set_type(self, cell_type):
		self.type = cell_type

	def details(self):
		output = self.type + " " + self.name + "(\n"
		for c in self.connections:
			output += str(c) + "\n"
		output += ")\n"
		return output

class Wire:
	def __init__(self, name, r):
		self.range = r
		self.name = name

	def __repr__(self):
		return self.name + str(self.range)

class Range:
	def __init__(self, start=None, end=None):
		if end is not None:
			self.type = 'Range'
			self.start = start
			self.end = end
		elif start is not None:
			self.type = 'Single'
			self.value = start
		else:
			self.type = 'None'

	def __repr__(self):
		if self.type is 'None':
			return ""
		elif self.type is 'Single':
			return "[" + str(self.value) + "]"
		elif self.type is 'Range':
			return "[" + str(self.start) + ":" + str(self.end) + "]"

	def parse_string(self, s):
		if s == None or s == "":
			self.type = 'None'
		elif ':' in s:
			self.type = 'Range'
			r = s.strip('[]').split(':')
			self.start = r[0]
			self.end = r[1]
		else:
			self.type = 'Single'
			self.value = s.strip('[]')
