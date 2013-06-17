# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# May 7, 2013

import classes

def main(all_wires, all_gates, gate_types):
	error_count = 0
	error_names = []
	pop_list = []
	for w in all_wires:
		# import pdb; pdb.set_trace()
		# all_wires[w] is a list of gate objects
		inputs = 0
		inref = ""
		outputs = 0
		# note that we want 1 output to a wire (from a gate)
		#	which can lead to many inputs (to gates)
		for g in all_wires[w]:
			d = g.getRefDirection(w)
			if d == "input": 
				inputs += 1
			elif d == "output": 
				outputs += 1
				inref = g
			else: 
				print "ERROR(w1): pin with direction", d, "for wire", w
		if inputs == 0 and outputs == 0:
			pop_list.append(w)
			continue
		if inputs == 0 or outputs == 0 or outputs > 1:
			print "ERROR(w2): wrong number of inputs (", inputs, ") or outputs (", outputs, ") on wire", w
			error_count += 1
			error_names.append(w)
			continue
		if inputs > 1:
			# print "WARNING: wire", w, "has fannout", outputs
			fan = classes.Gate(w)
			fan.setType(gate_types["fanout"])
			for g in all_wires[w]:
				if g.getRefDirection(w) is "output":
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
	for w in pop_list:
		all_wires.pop(w)
	print "Total of", error_count, "wire errors"
	# gate checker
	error_count = 0
	for g in all_gates:
		g = all_gates[g]
		for k in g.ref_pin:
			if type(k) is str and g.type.name.find("put_gate") == -1:
				print "ERROR(w4): Gate", g.name, "references wire", k
				error_count += 1
	print "Total of", error_count, "gate errors"
