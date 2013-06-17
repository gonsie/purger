

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

def write_gate_h(dir_prefix, types_list):
	f = open(dir_prefix+"gate.h", "w")
	f.write(header_generic+"\n")
	f.write(header_gate_h+"\n")
	f.write("#define GATE_TYPE_COUNT (" + str(len(types_list)) + ")\n\n")
	for index, t in enumerate(types_list):
		f.write("#define " + t + "_TYPE (" + str(index) + ")\n")
	f.write("\n"+footer_gate_h+"\n")
	f.close()

def write_gate_c(dir_prefix):
	f = open(dir_prefix+"gate.c", "w")
	f.write(header_generic+"\n")
	f.write(header_gate_c+"\n")
	f.write("\n"+footer_gate_c+"\n")
	f.close()

def out_files(all_gates, gate_types, filename_prefix):
	f = open(filename_prefix+"_types.txt", "w")
	types_list = []
	for k in gate_types:
		types_list.append(k)
		pins = gate_types[k].pin_direction.keys()
		pins.sort()
		f.write(str(len(types_list)-1)+" "+gate_types[k].name)
		for p in pins:
			f.write(" "+p)
		f.write("\n")
		instr = ' '.join(gate_types[k].in_order)
		outstr = ' '.join(gate_types[k].out_order)
		f.write("\t"+instr+"\n")
		f.write("\t"+outstr+"\n")
	f.close()
	write_gate_h(filename_prefix, types_list)
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
