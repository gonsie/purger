import itertools

import os.path
import cPickle
def LoadModule(module_name):
    pkl_name = module_name+"_obj.pkl"
    f = open(pkl_name, 'rb')
    mod = cPickle.load(f)
    f.close()
    return mod

# use as a placeholder for modules that appear in netlists
# aka megacells that don't belong to the gate library
class Module:
    def __init__(self, mname, idname=""):
        self.name = idname
        self.type = mname
        self.inputs = {}
        self.outputs= {}
        self.conx = {}
        self.dangling_refs = []

    def getDirection(self, wirename):
        if wirename in self.inputs:
            return "input"
        elif wirename in self.outputs:
            return "output"
        else:
            return None

    def connections(self, all_cells):
        p = [x for x in all_cells if all_cells[x].type.name == "input_gate"]
        for i in p:
            self.inputs[i[8:]] = all_cells[i].gid
        p = [x for x in all_cells if all_cells[x].type.name == "output_gate"]
        for i in p:
            self.outputs[i[8:]] = all_cells[i].gid

    def addConex(self, conxlist):
        # conxlist is a list of tuples:
        # elem[0] is name of a port
        # elem[1] is name of wire
        # or list of 0/1's (several wires set to const)
        for i in conxlist:
            self.conx[i[0]] = i[1]

    def updateRef(self, old_ref, new_ref):
        if old_ref in self.conx.values():
            for k in self.conx:
                if self.conx[k] == old_ref:
                    self.conx[k] = new_ref
        else:
            self.dangling_refs.append((old_ref, new_ref))

    def pkl(self):
        pkl_name = self.type+"_obj.pkl"
        if os.path.isfile(pkl_name):
            print "classes.Module ERROR:", self.type, "cannot be pkl'd, file exsits"
            return
        f = open(pkl_name, 'wb')
        cPickle.dump(self, f)
        f.close()

# use for timing groups in pins
class Timing_Group:
    def __init__(self, atts):
        self.atts = {atts[i][0] : atts[i][1] for i in range(len(atts))}
        self.id = "timing_"+self.atts['related_pin']
        self.rise = "0"
        self.fall = "0"
        self.setRF()
        self.parent = ""

    def setRF(self):
        if 'intrinsic_rise' in self.atts:
            self.rise = self.atts['intrinsic_rise']
        if 'intrinsic_fall' in self.atts:
            self.fall = self.atts['intrinsic_fall']
        if 'intrinsic_rise' not in self.atts and 'intrinsic_fall' not in self.atts:
            print "Warning: No Timing", self.atts

    def setParent(self, parent):
        self.parent = parent

    def generateC(self, input_order):
        output = ""
        in_pins = self.atts['related_pin'].split(' ')
        output += "\t\t//" + str(in_pins) + "\n"
        output += "\t\tif ("
        for p in in_pins:
            output += " in_pin == " + str(input_order.index(p)) + " || "
        output = output[:-3]
        output += ") {\n"
        if 'intrinsic_rise' in self.atts:
            output += "\t\t\tif (rising) {\n\t\t\t\treturn " + self.rise + ";\n\t\t\t}\n"
            if float(self.rise) == 0.0:
                print "ALERT: 0 rise delay at " + self.parent + " pin " + self.atts['related_pin']
        if 'intrinsic_fall' in self.atts:
            output += "\t\t\tif (!rising) {\n\t\t\t\treturn " + self.fall + ";\n\t\t\t}\n"
            if float(self.fall) == 0.0:
                print "ALERT: 0 fall delay at " + self.parent + " pin " + self.atts['related_pin']
        output += "\t\t}\n"
        return output

# use for latch, ff, state tables
class Special_Group:
    def __init__(self):
        self.type = None
        self.atts = {}
        # var1 and var2 change depending on type
        self.var1 = []
        self.var2 = []
        self.parent = ""

    def setParent(self, name):
        self.parent = name

    def setType(self, name):
        # type is set after arg and attribute processing
        self.type = name
        if name == 'statetable': self.expandStatetable()

    def addAtts(self, tuple_list):
        self.atts = {k : v for (k, v) in tuple_list}

    def addVars(self, var1, var2):
        self.var1 = [k for k in var1.split(' ') if len(k) > 0]
        self.var2 = [k for k in var2.split(' ') if len(k) > 0]

    def getInternalPins(self):
        plist = []
        if self.type == 'statetable':
            plist = self.var2
        else:
            plist = self.var1 + self.var2
        return {k : {'direction' : 'internal'} for k in plist}

    def getBEatts(self):
        badKeys = ['table', 'clear_preset_var1', 'clear_preset_var2']
        return {k for k in self.atts.keys() if k not in badKeys}

    def generateC(self, gate_type):
        output = "int " + gate_type.name + "_" + self.type
        output += " (int* input, int* internal, int* output) {\n"
        if self.type == 'statetable':
            output += self.generateStatetable(gate_type)
        elif self.type == 'latch':
            output += self.generateLatch(gate_type)
        elif self.type == 'ff':
            output += self.generateFf(gate_type)
        else:
            print "ERROR: unknown special type", self.type, "cannot generate function"
        output += "\treturn 1;\n}\n"
        return output

    def generateStatetable(self, gate_type):
        output = ""
        for line in self.atts['table']:
            input_node_values = line[0]
            current_internal_values = line[1]
            next_internal_values = line[2]
            # comment with contents of table line
            output += "\t//" + str(line) + "\n"
            # create conditionals
            conditions = []
            assignments = []
            for p, v in zip(self.var1, input_node_values):
                if v != "-":
                    conditions.append(gate_type.pins[p]['cref'] + " == " + v)
            for p, v in zip(self.var2, current_internal_values):
                if v != "-":
                    conditions.append(gate_type.pins[p]['cref'] + " == " + v)
            # create assignments
            for p, v in zip(self.var2, next_internal_values):
                if v != "N":
                    assignments.append("\t\t" + gate_type.pins[p]['cref'] + " = " + v + ";\n")
            # add to c code
            if len(assignments) > 0 and len(conditions) > 0:
                output += "\tif ("
                for c in conditions:
                    output += " " + c + " &&"
                output = output[:-2] + ") {\n"
                for a in assignments:
                    output += a
                output += "\t}\n"
        return output

    def expandPresets(self):
        if 'clear_preset_var1' not in self.atts or 'clear_preset_var2' not in self.atts:
            print "ERROR: expecting clear_preset_var# attributes in", self.type
            return
        for k, v in [['clear_preset_var1', self.var1[0]], ['clear_preset_var2', self.var2[0]]]:
            self.atts['o_'+k] = self.atts[k]
            if self.atts[k] == "N": self.atts[k] = v
            elif self.atts[k] == "H": self.atts[k] = '1'
            elif self.atts[k] == "L": self.atts[k] = '0'
            elif self.atts[k] == "T": self.atts[k] = "LOGIC_NOT(" + v + ")"
            elif self.atts[k] == "X": self.atts[k] = 'X'

    def generateLFF(self, v1, v2):
        output = ""
        if 'clear' in self.atts and 'preset' in self.atts:
            output += "\t//clear and preset\n"
            output += "\t//clear_preset_var1 = " + self.atts['clear_preset_var1'] + "\n"
            output += "\t//clear_preset_var2 = " + self.atts['clear_preset_var2'] + "\n"
            output += "\tif ( (" + self.atts['clear'] + ") && (" + self.atts['preset'] + ") ) {\n"
            self.expandPresets()
            output += "\t\t" + v1 + " = " + self.atts['clear_preset_var1'] + ";\n"
            output += "\t\t" + v2 + " = " + self.atts['clear_preset_var2'] + ";\n"
            output += "\t\treturn 1;\n\t}\n"
        if 'preset' in self.atts:
            output += "\t//preset = " + self.atts['o_preset'] + "\n"
            output += "\tif (" + self.atts['preset'] + ") {\n"
            output += "\t\t" + v1 + " = 1;\n"
            output += "\t\t" + v2 + " = 0;\n"
            output += "\t\treturn 1;\n\t}\n"
        if 'clear' in self.atts:
            output += "\t//clear = " + self.atts['o_clear'] + "\n"
            output += "\tif (" + self.atts['clear'] + ") {\n"
            output += "\t\t" + v1 + " = 0;\n"
            output += "\t\t" + v2 + " = 1;\n"
            output += "\t\treturn 1;\n\t}\n"
        return output

    def generateLatch(self, gate_type):
        # have generic latch logic here
        v1 = gate_type.pins[self.var1[0]]['cref']
        v2 = gate_type.pins[self.var2[0]]['cref']
        output = self.generateLFF(v1, v2)
        if 'enable' in self.atts:
            output += "\t//enable = " + self.atts['o_enable'] + "\n"
            output += "\t//data_in = " + self.atts['o_data_in'] + "\n"
            output += "\tif (" + self.atts['enable'] + ") {\n"
            output += "\t\t" + v1 + " = " + self.atts['data_in'] + ";\n"
            output += "\t\t" + v2 + " = LOGIC_NOT(" + v1 + ");\n"
            output += "\t\treturn 1;\n\t}\n"
        return output

    def generateFf(self, gate_type):
        # have generic ff logic here
        v1 = gate_type.pins[self.var1[0]]['cref']
        v2 = gate_type.pins[self.var2[0]]['cref']
        output = self.generateLFF(v1, v2)
        # assume all FF's are clocked_on CP
        cp = gate_type.pins['CP']['cref']
        output += "\t//clocked_on = CP\n"
        output += "\t//next_state = " + self.atts['o_next_state'] + "\n"
        output += "\tif (" + cp + ") {\n"
        output += "\t\t" + v1 + " = " + self.atts['next_state'] + ";\n"
        output += "\t\t" + v2 + " = LOGIC_NOT(" + v1 + ");\n"
        output += "\t\treturn 1;\n\t}\n"
        if 'internal' in self.atts['next_state']:
            print "ALERT: reverse needed for", self.parent
        return output

    def generateFuncCall(self, cell, pin):
        args = cell + "_" + pin + "_" + self.name + "("
        args = args[:-2] + ");"
        return args

    def generateFunc(self, cell, pin):
        params = "int " + cell + "_" + pin + "_" + self.name + " ("
        for att in self.atts:
            params += "int " + att + ", "
            args += att + ", "
        params = params[:-2] + ") {\n"
        params += "}\n"
        # do latch/ff/statetable logic here
        return params

    def expandStatetable(self):
        if self.type != "statetable":
            print "ERROR: wrong type for statetable expansion:", self.type
            return
        # ALERT : for some reason, statetables in lsi_lib don't actually reference internal nodes
        self.var2 = ["I"+k for k in self.var2]
        rawtable = self.atts['table'].split('\\\n')
        fulltable = []
        for l in rawtable:
            l = l.strip(' ')
            l = l.strip(',')
            if l.find('/') != -1:
                tmp = l
                # forward / deletion
                while l.find('/') != -1: l = l[:(l.find('/'))] + l[(l.find('/')+2):]
                fulltable.append(l)
                l = tmp
                # backward / deletion
                while l.find('/') != -1: l = l[:(l.find('/')-1)] + l[(l.find('/')+1):]
            fulltable.append(l)
        table = [[[j for j in k.split(' ') if len(j) > 0] for k in v.split(':')] for v in fulltable]
        self.atts['table'] = table

class Gate_Type:
    def __init__(self, name):
        self.name = name
        self.pins = {}
        self.specials = {}
        self.counts = {'input' : 0, 'output' : 0, 'internal' : 0}
        self.multibits = {}

    def add(self, name, entry):
        if name == 'pin':
            entry = entry.items()[0]
            self.pins[entry[0]] = entry[1]
        elif name == 'special':
            self.specials.update(entry)
            entry = entry.items()[0]
            self.pins.update(entry[1].getInternalPins())
            entry[1].setParent(self.name)
        elif name == 'multibit':
            entry = entry.items()[0]
            self.multibits[entry[0]] = entry[1]

    def setOrders(self):
        orders = ['input', 'output', 'internal']
        for o in orders:
            index = 0
            for s in self.getOrder(o):
                self.pins[s]['order'] = index
                index += 1
            self.counts[o] = index
        for p in self.pins:
            self.pins[p]['cref'] = self.pins[p]['direction'] + "[" + str(self.pins[p]['order']) + "]"
            # tack on timing here
            if any('timing' in k for k in self.pins[p].keys()):
                self.pins[p]['timing'] = [k for k in self.pins[p].keys() if 'timing' in k]
                for k in self.pins[p]['timing']:
                    self.pins[p][k].setParent(self.name)

    def generateC(self):
        if self.name == "fanout":
            return self.fanoutC()
        helpers = ""
        function = "void " + self.name + "_func  (int* input, int* internal, int* output) {\n"
        delay = "float " + self.name + "_delay_func (int in_pin, int out_pin, BOOL rising) {\n"
        if self.counts['output'] == 0:
            function += "\treturn;\n}\n"
            delay += "\ttw_error(TW_LOC, \"delay function called on no outputs\");\n\treturn 0;\n}\n"
            return function + delay
        if len(self.specials) > 0:
            k = 'ff' if 'ff' in self.specials else 'latch'
            # call the special first
            helpers += self.specials[k].generateC(self) + "\n"
            function += "\t" + self.name + "_" + k + "(input, internal, output);\n"
        # add comments with original bool_exp
        for p in self.getOrder('output'):
            if 'o_function' in self.pins[p]: function += "\t//" + p + " : " + self.pins[p]['o_function'] + "\n"
            if 'function' in self.pins[p]:
                function += "\t" + self.pins[p]['cref'] + " = " + self.pins[p]['function'] + ";\n"
                if 'output' in self.pins[p]['function']:
                    print "ALERT: output pin used on RHS of gate function!", self.name, p
            if 'timing' in self.pins[p]:
                delay += "\tif (out_pin == " + str(self.pins[p]['order']) + ") {\n"
                for t in self.pins[p]['timing']:
                    delay += self.pins[p][t].generateC(self.getOrder('input'))
                delay += "\t}\n"
        function += "\treturn;\n}\n"
        delay += "\treturn 1.0;\n}\n"
        return helpers + function + delay

    def fanoutC(self):
        output = ""
        output += "void fanout_func (int* input, int* internal, int* output) {\n"
        output += "\tint i;\n\tfor (i = 0; i < internal[0]; i++) {\n"
        output += "\t\toutput[i] = input[0];\n"
        output += "\t}\n\treturn;\n}\n"
        output += "float fanout_delay_func (int in_pin, int out_pin, BOOL rising) {\n"
        output += "\treturn 0.1;\n}\n"
        return output

    def getPinMap(self):
        pm = {}
        for p in self.pins:
            pm[p] = self.pins[p]['cref']
        return pm

    def getOrder(self, direction):
        ret = [k for k, v in self.pins.items() if direction in v.values()]
        ret.sort()
        return ret

class Gate:

    newid = itertools.count().next

    def __init__(self, name):
        self.gid = Gate.newid()
        self.name = name
        self.type = None
        self.in_pins = []
        self.out_pins = []
        self.const_assign = False
        self.pin_ref = {}

    def __repr__(self):
        return self.name+"_gate"

    def setType(self, t):
        self.type = t
        self.in_pins = [0] * t.counts['input']
        self.out_pins = [0] * t.counts['output']
        if self.type.name == "fanout":
            self.fan_out = []
        for p in self.type.pins:
            self.pin_ref[p] = None

    def addIORef(self, ref):
        if self.type.name == "fanout":
            print "ERROR(g1): don't use .addIORef on a fanout gate"
            return
        if len(self.in_pins) + len(self.out_pins) > 1:
            print "ERROR(g2): expecting one IO pin"
            return
        if self.type.name == "input_gate":
            self.pin_ref["out"] = ref
            self.out_pins[0] = ref
        elif self.type.name == "output_gate":
            self.pin_ref["in"] = ref
            self.in_pins[0] = ref
        else:
            print "ERROR(io): IOref for unknown type:", self.type.name

    def addRef(self, pin, ref, multiref_flag=False):
        if multiref_flag and pin not in self.type.multibits:
            print "ERROR(mb): bad multibit ref construction in", self.name, "of type", self.type.name
        if pin in self.type.multibits:
            if multiref_flag:
                # many wires already passed
                if len(ref) != self.type.multibits[pin]['width']:
                    print "ERROR(mb): wrong ref size:", len(ref), "for wire", pin, "width", self.type.multibits[pin]['width']
                multibit_ref = ref
            else:
                # this REF must be multibit as well!
                multibit_ref = parse_multibit_wire(ref, self.type.multibits[pin]['width'])
            for p, r in zip(self.type.multibits[pin]['wires'], multibit_ref):
                if type(r) is int:
                    self.addConstRef(p, r)
                else:
                    self.addRef(p, r)
            return
        if type(ref) is int:
            print "ERROR(##): Constant value on pin", pin
            return
        if pin not in self.pin_ref:
            print "ERROR(b0): Adding ref", ref, "on unknown pin", pin
        if self.pin_ref[pin]:
            if get_name(self.pin_ref[pin]) == get_name(ref):
                return
            print "ERROR(b2): Overwriting ref", self.pin_ref[pin], "on pin", pin, "with new ref", ref
        self.pin_ref[pin] = ref
        if self.type.name == "fanout" and pin != "in":
            print "ERROR(g3): don't use .addRef on a fanout gate"
            return
        if self.type.pins[pin]['direction'] == "input":
            self.in_pins[self.type.pins[pin]['order']] = ref
        if self.type.pins[pin]['direction'] == "output":
            self.out_pins[self.type.pins[pin]['order']] = ref

    def addConstRef(self, pin, ref):
        if self.pin_ref[pin]:
            print "ERROR(b#): Overwriting ref", self.pin_ref[pin], "on pin", pin, "with new ref", ref
        self.pin_ref[pin] = '#'+str(ref)

    def updateRef(self, old_ref, new_ref):
        old_name = get_name(old_ref)
        # must LOOP in case of multiple refs
        for p in self.pin_ref:
            if self.pin_ref[p] and get_name(self.pin_ref[p]) == old_name:
                self.pin_ref[p] = new_ref
        # TODO: multiple refs on I/O!!!!
        if old_ref in self.in_pins:
            self.in_pins[self.in_pins.index(old_ref)] = new_ref
        if old_ref in self.out_pins:
            self.out_pins[self.out_pins.index(old_ref)] = new_ref
        if self.type.name == "fanout" and old_ref in self.fan_out:
            print "ALERT: Updating ref in a fanout"
            self.fan_out[self.fan_out.index(old_ref)] = new_ref
            return

    def getRefDirection(self, ref):
        in_flag = False
        out_flag = False
        r = get_name(ref)
        for p in self.pin_ref:
            if self.pin_ref[p] and get_name(self.pin_ref[p]) == r:
                if self.type.pins[p]['direction'] == "input":
                    in_flag = True
                if self.type.pins[p]['direction'] == "output":
                    out_flag = True
        if not in_flag and not out_flag:
            print "ERROR(g6): unknown reference", ref, "for", self.name
            print self.pin_ref
            return None
        if in_flag and out_flag:
            return "both"
        return "input" if in_flag else "output"

    def addFanOut(self, ref):
        if self.type.name != "fanout":
            print "ERROR(g7): fanout gate type expected, instead:", self.type.name
            return
        self.fan_out.append(ref)

    def setAssign(self, constval):
        try:
            self.const_assign = int(constval)
        except Exception:
            print "ERROR(g10): assign constant not an int", constval
            self.const_assign = constval

class Range:
    def __init__(self, start=None, end=None):
        if end is not None:
            self.type = 'Range'
            self.start = min(start, end)
            self.end = max(start, end)
        elif start is not None:
            self.type = 'Single'
            self.value = start
        else:
            self.type = 'None'

    def __repr__(self):
        if self.type is 'None':
            return ""
        elif self.type is 'Single':
            return "[" + str(self.value) + "]"
        elif self.type is 'Range':
            return "[" + str(self.start) + ":" + str(self.end) + "]"

    def enumeration(self):
        if self.type is 'Range':
            return range(self.start, self.end + 1)
        elif self.type is 'Single':
            return [self.value]
        else:
            return []

    def parse_string(self, s):
        if s == None or s == "":
            self.type = 'None'
        elif ':' in s:
            self.type = 'Range'
            r = s.strip('[]').split(':')
            self.start = min(int(r[0]), int(r[1]))
            self.end = max(int(r[0]), int(r[1]))
        else:
            self.type = 'Single'
            self.value = int(s.strip('[]'))


def parse_multibit_wire(wire, size):
    if '[' in wire:
        print "ERROR(p): wire", wire, "has bit specification"
    r = []
    for i in range(size):
        r.append(wire+'['+str(i)+']')
    return r

def get_name(obj):
    if type(obj) is str:
        if obj.find('#') == 0:
            # TODO: should I do something special here??
            return obj
        else:
            return obj
    elif isinstance(obj, Gate):
        return obj.name
    else:
        print "ALERT: can't name", obj
        import pdb; pdb.set_trace()
        return None
