
import os.path

def load_clist(fname):
    r = []
    f = open(fname, 'r')
    for line in f:
        line = line.strip().split(' ')
        line[0] = int(line[0])
        r.append(tuple(line))
    f.close()
    return r

def load_md(fname):
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
    for l in rt:
        print l

import sys
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage:", sys.argv[0], "top_level_name"
    else:
        main(sys.argv[1])
