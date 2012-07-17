# Constructed when parsing is complete
# Turns a heirarchy of Atts into Cell and Pin objects
class Lib:
    def __init__(self, name, all_atts):
        self.name = name.lower()
        self.cells = dict()
        self.attributes = dict()
        for a in all_atts:
            if a.name == "cell":
                self.cells[a.label] = Cell(a.label, a)
            else:
                self.attributes[a.name] = a
        self.stats = self.gen_stats()
        for c in self.cells:
            self.stats += self.gen_stats(c)

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

    def get_cells(self):
        return self.cells.values()
    
    def get_cell(self, cell_name):
        return self.cells[cell_name]
    
    def cell_tokens(self):
        cd = {}
        for c in self.cells:
            cd[c] = 'CELL'
        return cd

    def gen_stats(self, cell_name=None):
        output = "Library " + self.name + ":\n"
        if cell_name:
            return self.cells[cell_name].stats
        output += "\t" + str(len(self.cells)) + " cells " + str(self.cells.keys()) + "\n"
        return output

class Pin:
    def __init__(self, p_name, p):
        self.name = p_name
        if p.name == "internal":
            self.direction = "internal"
            self.vector = "current"
            self.function = None
        else:
            self.direction = p.atts['direction'].value
            self.vector = self.direction
            if 'function' in p.atts:
                self.function = p.atts['function'].value
            else:
                self.function = None
        self.cstr = ""
        self.original = p

    def gen_c(self, index):
        s = self.vector + "[" + str(index) + "]"
        self.cstr = s
        return s

    def has_function(self):
        return self.function != None

class Cell:
    def __init__(self, c_name, c):
        self.name = c_name
        if 'statetable' in c.atts:
            self.statetable = c.atts['statetable']
        else:
            self.statetable = None
        if 'ff' in c.atts:
            self.ff = c.atts['ff']
        else:
            self.ff = None
        self.pins = []
        for p in c.pins:
            self.pins.append(Pin(p, c.pins[p]))
        self.pins.sort(key=lambda x: x.name)
        self.stats = self.gen_stats()
        self.original = c

    def pin_map(self):
        pm = {}
        for p in self.pins:
            pm[p.name] = p.cstr
        return pm

    def pin_tokens(self):
        pt = {}
        for p in self.pins:
            pt[p.name] = 'PIN'
        return pt

    def boolexps(self):
        be = []
        for p in self.pins:
            if p.has_function():
                be.append(p)
        return be

    def gen_stats(self):
        output = "Cell " + self.name + ":\n"
        self.inputs = []
        self.internals = []
        self.outputs = []
        for p in self.pins:
            if p.direction == 'input':
                p.gen_c(len(self.inputs))
                self.inputs.append(p.name)
            elif p.direction == 'internal':
                p.gen_c(len(self.internals))
                self.internals.append(p.name)
            elif p.direction == 'output':
                p.gen_c(len(self.outputs))
                self.outputs.append(p.name)
        output += "\t" + str(len(self.inputs)) + " input pins " + str(self.inputs) + "\n"
        if len(self.internals) != 0:
            output += "\t" + str(len(self.internals)) + " internal pins " + str(self.internals) + "\n"
        output += "\t" + str(len(self.outputs)) + " output pins " + str(self.outputs) + "\n"
        return output

# This generic class is used during parsing, for simple object construction
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
                elif a.name == "ff":
                    for internal in a.args:
                        self.pins[internal] = Att('internal')
                else:
                    self.atts[a.name] = a
        else:
            self.atts = dict()
            for i in v[0]:
                self.atts[i.name] = i
        
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
