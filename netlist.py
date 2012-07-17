class Module:
	def __init__(self, name, list_of_ports, module_items):
		self.name = name
		self.ports = list_of_ports
		self.items = module_items

class Net:
	def __init__(self, name, connections):
		self.name = name
		self.connections = connections