
import os.path

g_prefix = "Current"
header = '''//Elsa Gonsiorowski
//Rensselaer Polytechnic Institute
'''

class Module:
    def __init__(self, name, count):
        self.name = name
        self.count = count
        self.parent = None
        self.route = self.name
        self.route_count = count
        self.children = []
        self.gate_count = 0

    def load(self):
        self.children = load_clist(self.name)
        for c in self.children:
            c.parent = self.name
            c.route = self.route + "." + c.route
            c.route_count = self.route_count * c.route_count
            c.load()
        self.gate_count = load_md(self.name)

    def printRouteCount(self, index, offset):
        route = self.route + (' '*(22-len(self.route)))
        ostr = '\t'.join([route, str(self.count), str(self.route_count), str(index), str(offset), str(self.gate_count)])
        print ostr
        for i in range(self.route_count-1):
            j = i+1
            ostr = ' '*22 + '\t\t\t\t'
            print ostr+str(offset+(j*self.gate_count))
        offset += self.route_count * self.gate_count
        index += self.route_count
        for c in self.children:
            (index, offset) = c.printRouteCount(index, offset)
        return index, offset

    def poundDef(self, ostr, index):
        ostr +=  "#define RO_"+self.name+"\t("+str(index)+")\n"
        index += self.route_count
        for c in self.children:
            (ostr, index) = c.poundDef(ostr, index)
        return (ostr, index)

    def arrayStr(self, ostr, offset):
        for i in range(self.route_count):
            ostr += str(offset)+", "
            offset += self.gate_count
        for c in self.children:
            (ostr, offset) = c.arrayStr(ostr, offset)
        return ostr, offset

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

def printRouting(top_mod):
    # .h file
    fname = g_prefix+"/"+top_mod.name+"-routing.h"
    f = open(fname, 'w')
    f.write(header+"\n")
    f.write("#ifndef _routing_h\n")
    f.write("#define _routing_h\n\n")
    (ostr, total) = top_mod.poundDef("", 0)
    f.write("#define RO_TOTAL ("+str(total)+")\n")
    f.write(ostr)
    f.write("\n#endif\n")
    f.close()
    # .c file
    fname = g_prefix+"/"+top_mod.name+"-routing.c"
    f = open(fname, 'w')
    f.write(header+"\n")
    (ostr, offset) = top_mod.arrayStr("", 0)
    f.write("#include \"routing.h\"\n\n")
    f.write("int routing_table[RO_TOTAL+1] = {\n")
    f.write(ostr)
    f.write(str(offset)+",")
    f.write("\n\t};\n")
    f.close()

def process(top_level):
    top = Module(top_level, 1)
    top.load()
    # top.printDepth(0)
    # top.printOffsets(0)
    # top.printRoute()
    i, o = top.printRouteCount(0, 0)
    ostr = ' '*22 + '\t\t\t\t'
    print ostr + str(o)
    printRouting(top)

import sys
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage:", sys.argv[0], "top_level_name [prefix]"
    else:
        if len(sys.argv) == 3:
            g_prefix = sys.argv[2]
        process(sys.argv[1])
