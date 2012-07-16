class Lib:
    def __init__(self, name, all_atts):
        self.name = name.lower()
        self.cells = dict()
        self.attributes = dict()
        for a in all_atts:
            if a.name == "cell":
                self.cells[a.label] = a
            else:
                self.attributes[a.name] = a
    
    def __repr__(self):
        output = ""
        output += "* Library " + self.name + "\n"
        output += "** Attributes:\n"
        for a in self.attributes:
            output += "  - " + str(self.attributes[a]) + "\n"
        output += "** Cells:\n"
        for a in self.cells:
            output += "  - " + str(self.cells[a]) + "\n"
            for p in self.cells[a].pins:
                output += "    - " + str(a.pins[p]) + "\n"
        return output
    
    def generate_c(self):
        comments = "//Elsa Gonsiorowski\n"
        comments += "//Automatically Generated on " + datetime.datetime.now().isoformat() + "\n"
        comments += "//From Liberty Library " + self.name + ".lib\n\n"
        hf = open('lib_'+self.name+'_gate.h', 'w')
        hf.write(comments)
        hf.write("#ifndef _gate_h\n#define _gate_h\n\n")
        cf = open('lib_'+self.name+'_gate.c', 'w')
        cf.write(comments)
        cf.write("#include \"gates_model.h\"\n#include \"gate.h\"\n\n")
        max_i = 0
        max_o = 0
        gate_count = 0
        for c in self.cells:
            cell = lib.cells[c]
            ocount = 0
            icount = 0
            hf.write("#define " + c + "_GATE (" + str(gate_count) + ")\n")
            gate_count += 1
            for p in cell.pins:
                pin = cell.pins[p]
                if pin.atts['direction'].value == 'output':
                    #print "\t", p, "\t", pin.atts['function']
                    ocount += 1
                else:
                    icount += 1
            cf.write(cell.generate_c())
            cf.write("\n")
            #print "\t", icount, "inputs and", ocount, "outputs"
            max_i = max(max_i, icount)
            max_o = max(max_o, ocount)
        hf.write("\n#define MAX_GATE_INPUTS " + str(max_i))
        hf.write("\n#define MAX_GATE_OUTPUTS " + str(max_o))
        hf.write("\n#define GATE_TYPE_COUNT " + str(gate_count))
        hf.write("\n#endif\n")
        hf.close()
        cf.write("\n")
        cf.close()

class Att:
    def __init__(self, name):
        self.name = name.lower()
    
    def set_simple(self, v):
        self.type = "simple"
        self.value = v

    def set_complex(self, a):
        self.type = "complex"
        self.args = a

    def set_group(self, a, v):
        self.type = "group"
        self.args = a
        if self.name == "cell" or self.name == "pin":
            self.label = a[0]
        if self.name == "cell":
            self.pins = dict()
            self.atts = dict()
            for a in v[0]:
                if a.name == "pin":
                    self.pins[a.label] = a
                else:
                    self.atts[a.name] = a
        else:
            self.atts = dict()
            for i in v[0]:
                self.atts[i.name] = i
    
    # ONLY FOR CELLS
    def generate_c(self):
        if self.name != "cell":
            print "ERROR: generate_c() function undefined for type", self.name
            return
        output = "int " + self.label + "_func (vector input, vector output) {\n"
#        output += "\tint change_flag = FALSE\n"
        ocount = 0
        icount = 0
        for p in self.pins:
            pin = self.pins[p]
            if pin.atts['direction'].value == 'output':
                output += "\t//" + pin.label + " = " + pin.atts['function'].value + "\n"
                ocount += 1
            else:
                icount += 1
        output += "\t//" + str(icount) + " inputs and " + str(ocount) + " outputs\n"
        if "ff" in self.atts:
            print "testing FF:", self.atts["ff"]
        if "statetable" in self.atts:
            print "testing ST:", self.atts["statetable"]
        output += "}\n"
        return output
    
    # ONLY FOR CELLS
    def pins(self):
        if self.name != "cell":
            print "ERROR: pin() function undefined for type", self.name
            return
        l = self.pins.keys()
        l.sort()
        return l
    
    def __repr__(self):
        output = ""
        if self.name == "cell" or self.name == "pin":
            output += self.label
        elif self.type == "simple":
            output += self.name + " = " + self.value + " ;"
        elif self.type == "complex":
            output += self.name + " ( " + str(self.args) + " ) ;"
        elif self.type == "group":
            output += self.name + " ( " + str(self.args) + " ) { " + str(self.atts) + " } ;"
        return output
