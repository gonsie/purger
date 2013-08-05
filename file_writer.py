

header='''//Elsa Gonsiorowski
//Rensselaer Polytechnic Institute
'''

def write_gate_h(filename_prefix, types_list):
	f = open("current/"+filename_prefix+"_types.h", "w")
	f.write(header+"\n")
	f.write("#ifndef _"+filename_prefix+"_types_h\n")
	f.write("#define _"+filename_prefix+"_types_h\n\n")
	# total gate count def
	f.write("#define GATE_TYPE_COUNT (" + str(len(types_list)) + ")\n\n")
	# defs with gate types
	for index, t in enumerate(types_list):
		f.write("#define " + t + "_TYPE (" + str(index) + ")\n")
	f.write("\n#endif\n")
	f.close()

def write_gate_c(filename_prefix, types_list, gate_types):
	f = open("current/"+filename_prefix+"_functions.c", "w")
	f.write(header+"\n")
	f.write("#include <stdio.h>\n")
	f.write("#include \"gates_model.h\"\n")
	f.write("#include \""+filename_prefix+"_types.h\"\n\n")
	# gate functions
	for k in types_list:
		f.write(gate_types[k].generateC() + "\n")
	# function array
	f.write("gate_func function_array[GATE_TYPE_COUNT] = {\n")
	for t in types_list:
		f.write("\t&" + t + "_func,\n")
	f.write("};\n")
	f.close()

def write_lookup_c(filename_prefix, types_list, gate_types):
	f = open("current/"+filename_prefix+"_lookups.c", "w")
	f.write(header+"\n")
	f.write("#include \"gates_model.h\"\n")
	# input size
	f.write("\nint gate_input_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['input']) + ", ")
	f.write("\n\t};\n")
	# internal size
	f.write("\nint gate_internal_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['internal']) + ", ")
	f.write("\n\t};\n")
	# output size
	f.write("\nint gate_output_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['output']) + ", ")
	f.write("\n\t};\n")
	f.close()

def generateC(filename_prefix, gate_types):
	# this file just lists all cells with pins
	f = open("current/"+filename_prefix+"_lib.txt", "w")
	types_list = gate_types.keys()
	## master list of cell name to cell number ##
	types_list.sort()
	for i, k in enumerate(types_list):
		f.write(str(i) + " " + gate_types[k].name + "\n")
		instr = ' '.join(gate_types[k].getOrder('input'))
		outstr = ' '.join(gate_types[k].getOrder('output'))
		f.write("\t"+instr+"\n")
		f.write("\t"+outstr+"\n")
	f.close()
	write_gate_h(filename_prefix, types_list)
	write_gate_c(filename_prefix, types_list, gate_types)
	write_lookup_c(filename_prefix, types_list, gate_types)

def generateRoss(filename_prefix, gate_types, all_gates):
	types_list = gate_types.keys()
	types_list.sort()
	types_list.append(None)
	f = open("current/"+filename_prefix+"_gates.txt", "w")
	for g in all_gates:
		g = all_gates[g]
		f.write(str(g.gid)+" "+str(types_list.index(g.type.name))+" ")
		inlist = []
		for r in g.ref_pin:
			if type(r) is str:
				# always strings for io_cells
				# print "ERROR(w3): ref is string:", r, "for", g.name
				continue
			if g.getRefDirection(r) == "input":
				p3 = r.getOutIndex(g)
				inlist.append((g.getRefPin(r), str(r.gid), str(p3)))
		inlist.sort()
		instr = ' '.join([' '.join(p[1:]) for p in inlist])
		f.write(instr)
		# fanout special case
		if g.type.name == 'fanout':
			f.write(" "+str(g.type.counts['output']))
		f.write("\n")
	f.close()

