
import os.path

g_prefix = "Current"

class Module:
    def __init__(self, name, count):
        self.name = name
        self.count = count
        self.parent = None
        self.children = []
        self.gate_count = 0

    def load(self):
        self.children = load_clist(self.name)
        for c in self.children:
            c.parent = self.name
            c.load()
        self.gate_count = load_md(self.name)

    def printDepth(self, depth):
        ostr = "\t"*depth
        ostr += str(self.count) + " " + self.name
        print ostr
        for c in self.children:
            c.printDepth(depth+1)

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

def calc_offsets(top_level):
    offset_list = []
    offset = 0
    r = [(1, top_level)]
    for i, n in r:
        #i, n = r.pop(0)
        d = "Data/"+n+".clist"
        if os.path.isfile(d):
            r += load_clist(d)
        md = "Generated/"+n+"/"+n+".metadata"
        count = load_md(md)
        for j in range(i):
            offset_list.append((offset, n))
            offset += count
    return offset_list

def calc_routing(offset_list):
    routing_table = []
    prev_n = ""
    n_count = 0
    for i, n in offset_list:
        if n == prev_n:
            n_count += 1
        else:
            n_count = 0
        prev_n = n
        route = n+"."+str(n_count)+"."
        routing_table.append((n, i, route))
    return routing_table

def main(top_level):
    ol = calc_offsets(top_level)
    rt = calc_routing(ol)

def process(top_level):
    top = Module(top_level, 1)
    top.load()
    top.printDepth(0)

import sys
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage:", sys.argv[0], "top_level_name [prefix]"
    else:
        if len(sys.argv) == 3:
            global g_prefix
            g_prefix = sys.argv[2]
        main(sys.argv[1])
