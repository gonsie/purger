# Module
# - [ Item ]
# 	- ( type, Wire ) (input, output, wire)
# 	- { Wire : Wire } (assign)
# 	- Net
#		- [ { Port : Wire } ]


class Module:
	def __init__(self, name, list_of_ports, module_items):
		self.name = name
		self.originals = [list_of_ports, module_items]
		self.ports = []
		self.inputs = []
		self.outputs = []
		self.wires = []
		self.assigns = {}
		self.nets = []
		for p in list_of_ports:
			self.ports.extend(p.enumeration())
		for item in module_items:
			if type(item) is tuple:
				if item[0] == 'input':
					self.inputs.extend(item[1].enumeration())
				elif item[0] == 'output':
					self.outputs.extend(item[1].enumeration())
				elif item[0] == 'wire':
					self.wires.extend(item[1].enumeration())
				else:
					print "ERROR: unrecognized type", item[0]
			elif type(item) is dict:
				self.assigns.update(item)
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

	def net_stats(self):
		cell_types = {}
		for n in self.nets:
			if n.type not in cell_types:
				cell_types[n.type] = 1
			else:
				cell_types[n.type] += 1
		for ct in cell_types:
			print ct, cell_types[ct]

	def wire_stats(self, lib):
		wd = {}
		for w in self.wires:
			wd[w] = [0] * 6
			# input, output
			# assign lhs, assign rhs
			# net inputs, net outputs
			if w in self.inputs:
				wd[w][0] += 1
			if w in self.outputs:
				wd[w][1] += 1
			if w in self.assigns.keys():
				wd[w][2] += 1
			if w in self.assigns.values():
				wd[w][3] += 1
		for n in self.nets:
			for conx in n.connections:
				name = conx.keys()[0]
	 			wire = conx.values()[0]
				d = lib.get_direction(n.type, name)
				if d == 'input':
					wd[w][4] += 1
				elif d == 'output':
					wd[w][5] += 1
		# max fan out
		maxfo = 0
		maxfon = ''
		for w in wd:
			if wd[w][4] > maxfo:
				maxfo = wd[w][4]
				maxfon = w
		print "Max fan out on", maxfon, "with", maxfo


	def create_dot(self):
		output = "digraph " + self.name + " {\n\t"
		output += "node [shape=point]\n\t"
		for a in self.assigns:
			output += "\"" + str(a.keys()[0]) + "\" -> \"" + str(a.values()[0]) + "\"\n\t"
		output += "}"
		return output


class Net:
	def __init__(self, name, connections):
		self.name = name
		self.connections = connections
		self.connections.sort()

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

	def enumeration(self):
		r = self.range.enumeration()
		if len(r) is 0:
			return [self.name]
		ret = []
		for d in r:
			ret.append(self.name+"["+str(d)+"]")
		return ret

class Range:
	def __init__(self, start=None, end=None):
		if end is not None:
			self.type = 'Range'
			self.start = min(start, end)
			self.end = max(start, end)
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

	def enumeration(self):
		if self.type is 'Range':
			return range(self.start, self.end + 1)
		elif self.type is 'Single':
			return [self.value]
		else:
			return []

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
