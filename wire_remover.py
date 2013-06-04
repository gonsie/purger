# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# May 7, 2013

def main(all_wires, all_gates, gate_types):
	for w in all_wires:
		# all_wires[w] is a list of gate objects
		inputs = 0
		inref = ""
		outputs = 0
		for g in all_wires[w]:
			d = g.getRefDirection(w)
			if d is "input": inputs += 1; inref = g
			if d is "output": outputs += 1
		if inputs is 0 or outputs is 0 or inputs > 1:
			print "ERROR: wrong number of inputs (", inputs, ") or outputs (", outputs, ") on wire", w
			break
		if outputs > 1:
			# print "WARNING: wire", w, "has fannout", outputs
			fan = classes.gate(w)
			fan.setType(gate_types["fanout"])
			for g in all_wires[w]:
				if g.getRefDirection(w) is "input":
					fan.addRef("in", inref)
				else:
					fan.addFanOut(g)
				g.updateRef(w, fan)
			all_gates[fan.name] = fan
		else:
			g0 = all_wires[w][0]
			g1 = all_wires[w][1]
			g0.updateRef(w, g1)
			g1.updateRef(w, g0)
