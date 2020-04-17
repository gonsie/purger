
import os.path

# GLOBAL SETTINGS
g_prefix = "Current"
header = '''//Elsa Gonsiorowski
//Rensselaer Polytechnic Institute
'''
lps_per_kp = 18

class Module:
    def __init__(self, name, count):
        self.name = name
        self.fname = name+".vSyn.gates."
        self.count = count
        self.parent = None
        self.route = self.name
        self.route_count = count
        self.children = []
        self.gate_count = 0
        self.part_count = 0

    def load(self):
        self.children = load_clist(self.name)
        for c in self.children:
            c.parent = self.name
            c.route = self.route + "." + c.route
            c.route_count = self.route_count * c.route_count
            c.load()
        self.gate_count = load_md(self.name)
        self.part_count = self.gate_count / 18
        self.index = -1
        self.offset = -1

    def parts(self):
        global lps_per_kp
        r = 0
        for c in self.children:
            r += c.parts()
        r += ((self.gate_count / lps_per_kp) * self.route_count)
        return r

    def printRouteCount(self, index, offset, parts):
        route = self.route + (' '*(22-len(self.route)))
        ostr = '\t'.join([route, str(self.count), str(self.route_count), str(index), str(offset), str(self.gate_count), str(self.part_count)])
        self.index = index
        self.offset = offset
        print ostr
        link_str = self.name+".0 "+str(self.offset)+"\n"
        for i in range(self.route_count-1):
            j = i+1
            ostr = ' '*22 + '\t\t\t\t'
            print ostr+str(offset+(j*self.gate_count))+'\t\t'+str(self.part_count)
            link_str += self.name+"."+str(j)+" "+str(offset+(j*self.gate_count))+"\n"
        #print link_str # used to generate the cpu.links file
        offset += self.route_count * self.gate_count
        index += self.route_count
        parts += self.route_count * self.part_count
        for c in self.children:
            (index, offset, parts) = c.printRouteCount(index, offset, parts)
        return index, offset, parts

    def poundDef(self, ostr, index):
        ostr +=  "#define RO_"+self.name+"\t("+str(index)+")\n"
        index += self.route_count
        for c in self.children:
            (ostr, index) = c.poundDef(ostr, index)
        return (ostr, index)

    def arrayLP(self, arr, offset):
        for i in range(self.route_count):
            arr.append(offset)
            offset += self.gate_count
        for c in self.children:
            (arr, offset) = c.arrayLP(arr, offset)
        return arr, offset

    def arrayKP(self, arr, offset):
        global lps_per_kp
        for i in range(self.route_count):
            arr.append(offset)
            offset += (self.gate_count / lps_per_kp)
        for c in self.children:
            (arr, offset) = c.arrayKP(arr, offset)
        return arr, offset

    def printDepth(self, depth):
        ostr = "\t"*depth
        ostr += str(self.count) + " " + self.name
        print ostr
        for c in self.children:
            c.printDepth(depth+1)

    def printRoute(self):
        print self.route
        for c in self.children:
            c.printRoute()

    def printOffsets(self, offset):
        for i in range(self.count):
            print self.name, offset
            offset += self.gate_count
            for c in self.children:
                offset = c.printOffsets(offset)
        return offset

    def printCmds(self):
        # print self.name, self.count, self.route_count, self.index, self.offset, self.gate_count
        for i in range(self.count):
            print "mv", self.fname+str(i), self.fname+str(self.index+i)
            for j in range((self.route_count / self.count)-1):
                k = j+1
                print "cp", self.fname+str(self.index+i), self.fname+str(self.index+k)
        for c in self.children:
            c.printCmds()

def load_clist(mod_name):
    fname = "Data/"+mod_name+".clist"
    if not os.path.isfile(fname):
        return []
    r = []
    f = open(fname, 'r')
    for line in f:
        line = line.strip().split(' ')
        line[0] = int(line[0])
        r.append(Module(line[1], line[0]))
    f.close()
    return r

def load_md(mod_name):
    fname = "Generated/"+mod_name+"/"+mod_name+".metadata"
    f = open(fname, 'r')
    line = f.readline().strip()
    f.close()
    return int(line)

def calcRankRouting(top_mod, np):
    global lps_per_kp
    (a, o) = top_mod.arrayLP([], 0)
    a.append(o)
    d = [a[i+1]-a[i] for i in range(len(a)-1)]
    b = [i/lps_per_kp for i in d]
    c = [x - (y*lps_per_kp) for x,y in zip(d,b)]
    lp_in_part = []
    for i in range(len(b)):
        for j in range(b[i]):
                lp_in_part.append(lps_per_kp)
                if j < c[i]:
                        lp_in_part[-1]+=1
    total_parts = sum(b)
    parts_per_rank = total_parts / np
    parts_per_rank_extra = total_parts - (parts_per_rank * np)
    parts_on_rank = [parts_per_rank for i in range(np)]
    for i in range(parts_per_rank_extra):
        parts_on_rank[i] += 1
    e = [0]
    for i in range(np):
        e.append(parts_on_rank[i] + e[i])
    lps_on_rank = []
    for i in range(np):
        lps_on_rank.append(sum(lp_in_part[e[i]:e[i+1]]))
    gid_offset = [0]
    for i in range(np):
        gid_offset.append(lps_on_rank[i] + gid_offset[i])
    return gid_offset

def printRouting(top_mod, total_parts):
    # .h file
    fname = g_prefix+"/"+top_mod.name+"-routing.h"
    f = open(fname, 'w')
    f.write(header+"\n")
    f.write("#ifndef _routing_h\n")
    f.write("#define _routing_h\n\n")
    (ostr, total) = top_mod.poundDef("", 0)
    f.write("#define RO_TOTAL ("+str(total)+")\n")
    f.write(ostr)
    global lps_per_kp
    f.write("\n#define LPS_PER_KP ("+str(lps_per_kp)+")\n")
    t_parts = top_mod.parts()
    f.write("\n#define TOTAL_PARTS ("+str(total_parts)+")\n")
    f.write("\n#endif\n")
    f.close()
    # .c file
    fname = g_prefix+"/"+top_mod.name+"-routing.c"
    f = open(fname, 'w')
    f.write(header+"\n")
    f.write("#include \"ross.h\"\n")
    f.write("#include \"routing.h\"\n")
    f.write("#include \"generic-model.h\"\n\n")
    # lps per module table
    (arr, offset) = top_mod.arrayLP([], 0)
    sarr = [str(i) for i in arr] + [str(offset)]
    f.write("int routing_table_lp[RO_TOTAL+1] = {\n")
    f.write(", ".join(sarr))
    f.write("\n\t};\n")
    # parts per module table
    (arr, offset) = top_mod.arrayKP([], 0)
    sarr = [str(i) for i in arr] + [str(offset)]
    f.write("int routing_table_kp[RO_TOTAL+1] = {\n")
    f.write(", ".join(sarr))
    f.write("\n\t};\n")
    # pre-calculate MPI-rank routing
    np = 524288 # 2^19
    mapstr = "\nintarrptr routing_table_mapper(int np) {\n\tswitch (np) {\n"
    while np > 0:
        arr = calcRankRouting(top_mod, np)
        sarr = [str(i) for i in arr]
        f.write("int routing_map_"+str(np)+"["+str(np+1)+"] = {\n")
        f.write(", ".join(sarr))
        f.write("\n\t};\n")
        mapstr += "\tcase "+str(np)+":\n\t\treturn &routing_map_"+str(np)+";\n"
        np = np/2
    mapstr += "\tdefault:\n\t\ttw_error(TW_LOC, \"ERROR: no mapping for %d nodes\", np);\n\t}\n}\n"
    f.write(mapstr)
    f.close()

def process(top_level):
    top = Module(top_level, 1)
    top.load()
    # top.printDepth(0)
    # top.printOffsets(0)
    # top.printRoute()
    print "Calling top.printRouteCount"
    i, o, p = top.printRouteCount(0, 0, 0)
    ostr = ' '*22 + '\t\t\t\t'
    print ostr + str(o) + '\tParts: ' + str(p)
    print "Calling printRouting(top)"
    printRouting(top, p)
    #top.printCmds()

import sys
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage:", sys.argv[0], "top_level_name [prefix]"
    else:
        if len(sys.argv) == 3:
            g_prefix = sys.argv[2]
        process(sys.argv[1])
