# class Module:
# 	def __init__(self, name, list_of_ports, module_items):
# 		self.name = name
# 		self.ports = list_of_ports
# 		self.items = module_items

# 	def __repr__(self):
# 		return self.name

# class Net:
# 	def __init__(self, name, connections):
# 		self.name = name
# 		self.connections = connections

# 	def __repr__(self):
# 		return self.name

# 	def set_type(self, cell_type):
# 		self.type = cell_type


class Module:
	def __init__(self, name, list_of_ports, module_items):
		# module ccx (scan_in, scan_out);
		# input scan_in
		# output scan_out
		# FD1 ccx_fd (.A(scan_in), .Z(scan_out));
		# endmodule
		self.name = name
		self.ports = list_of_ports
		self.wire_list = dict()
		self.net_list = dict()
		assigns = []
		for item in module_items:
			if isinstance(item, Wire):
				self.wire_list[item.name] = item
			elif isinstance(item, Parse_Assignment):
				assigns.append(item)
			elif isinstance(item, Net):
				self.net_list[item.name] = item
		# start by linking assigns
		for a in assigns:
			wire_list[a.lhs].outputs.append[wire_list[a.rhs]]
			wire_list[a.rhs].inputs.append[wire_list[a.lhs]]

class Item:
	def __init__(self, name, t):
		self.name = name
		self.type = t
		self.inputs = []
		self.outputs = []

class Parse_Assignment:
	def __init__(self, rhs, lhs):
		self.rhs = rhs
		self.lhs = lhs		

class Wire(Item):
	def add_input(self, ref_obj):
		self.inputs.append(ref_obj)

	def add_output(self, ref_obj):
		self.outputs.append(ref_obj)

class Net(Item):
	def __init__(self, name, t):
		self.name = name
		self.type = t
		self.wires = []
		self.pins = []
		self.connections = 0

	def set_type(self, t):
		self.type = t

	def add_connection(self, pin, wire):
		self.connections += 1
		self.wires.append(wire)
		self.pins.append(pin)

	def __repr__(self):
		output = self.type + " " + self.name + " ("
		for i in range(self.connections):
			output += self.pins[i] + "(" + self.wires[i] + "), "
		output = output[:-2] + ");"