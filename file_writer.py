

header_generic='''//Elsa Gonsiorowski
//Rensselaer Polytechnic Institute
'''

header_gate_c='''#include <stdio.h>
#include "gates_model.h"
#include "gate.h"
'''

footer_gate_c='''
'''

header_gate_h='''#ifndef _gate_h
#define _gate_h
'''

footer_gate_h='''#endif
'''

fake_gate_funcs='''int input_gate_func (vector input, vector output){
	return 0;
}

int output_gate_func (vector input, vector output){
	return 0;
}

int fanout_func (vector input, vector output){
	// assume input/output array sizes are at least 1
	// assume all output array values are equal
	if (output->array[0].value == input->array[0].value){
		return 0;
	} else {
		int i;
		for (i = 0; i < output->size; i++){
			output->array[i].value = input->array[0].value;
		}
		return 1;
	}
}
'''


def write_gate_h(dir_prefix, types_list):
	f = open(dir_prefix+"_types.h", "w")
	f.write(header_generic+"\n")
	f.write(header_gate_h+"\n")
	# total gate count def
	f.write("#define GATE_TYPE_COUNT (" + str(len(types_list)) + ")\n\n")
	# defs with gate types
	for index, t in enumerate(types_list):
		f.write("#define " + t + "_TYPE (" + str(index) + ")\n")
	f.write("\n"+footer_gate_h+"\n")
	f.close()

def write_gate_c(dir_prefix, types_list, gate_types):
	f = open(dir_prefix+"_functions.c", "w")
	f.write(header_generic+"\n")
	f.write(header_gate_c+"\n")
	# gate functions
	for k in types_list:
		print k
		f.write(gate_types[k].generateC() + "\n")
	# function array
	f.write("gate_func function_array[GATE_TYPE_COUNT] = {\n")
	for t in types_list:
		f.write("\t&" + t + "_func,\n")
	f.write("}\n")
	f.write("\n"+footer_gate_c+"\n")
	f.close()

def generateC(filename_prefix, gate_types):
	# this file just lists all cells with pins
	f = open(filename_prefix+"_lib.txt", "w")
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

def generateRoss(filename_prefix, gate_types, all_gates):
	types_list.append(None)
	f = open(filename_prefix+"_gates.txt", "w")
	for g in all_gates:
		g = all_gates[g]
		f.write(str(g.gid)+" "+str(types_list.index(g.type.name))+" ")
		outcount = 0
		inlist = []
		for r in g.ref_pin:
			if type(r) is str:
				# always strings for io_cells
				# print "ERROR(w3): ref is string:", r, "for", g.name
				continue
			if g.getRefDirection(r) == "output":
				outcount += 1
			else:
				p3 = r.getOutIndex(g)
				inlist.append((g.getRefPin(r), str(r.gid), str(p3)))
		inlist.sort()
		instr = ' '.join([' '.join(p[1:]) for p in inlist])
		f.write(str(outcount)+" "+instr+"\n")
	f.close()

def generateLookups(filename_prefix, gate_types):
	f = open(filename_prefix+"_lookups.c", "w")
	types_list = gate_types.keys()
	types_list.sort()
	# header
	# input size
	f.write("\nint gate_input_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['input']) + ", ")
	f.write("\n\t}\n")
	# internal size
	f.write("\nint gate_internal_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['internal']) + ", ")
	f.write("\n\t}\n")
	# output size
	f.write("\nint gate_output_size[GATE_TYPE_COUNT] = {\n\t")
	for t in types_list:
		f.write(str(gate_types[t].counts['output']) + ", ")
	f.write("\n\t}\n")
	# footer
	f.close()
