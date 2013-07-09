# use for latch, ff, state tables
class Special_Group:
    def __init__(self):
        self.type = None
        self.atts = {}
        self.internal_pins = []
        self.external_pins = []

    def setType(self, name):
        # type is set after arg and attribute processing
        self.type = name

    def addAtts(self, tuple_list):
        self.atts = {k : v for (k, v) in tuple_list}

    def addVars(self, var1, var2):
        # check if it's a statetable
        if ' ' in var1:
            self.external_pins = [k for k in var1.split(' ') if len(k) > 0]
            self.internal_pins = [k for k in var2.split(' ') if len(k) > 0]
        else:
            self.internal_pins = [var1, var2]

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
        rawtable = self.atts['table'].split('\\\n')
        table = []
        for l in table:
            l = l.strip(' ')
            l = l.strip(',')
            if l.find('/') != -1:
                tmp = l
                # forward / deletion
                while l.find('/') != -1: l = l[:(l.find('/'))] + l[(l.find('/')+2):]
                table.append(l)
                l = tmp
                # backward / deletion
                while l.find('/') != -1: l = l[:(l.find('/')-1)] + l[(l.find('/')+1):]
            table.append(l)
            self.atts['table'] = table

class Gate_Type:
    def __init__(self, name):
        self.name = name
        self.pin_direction = {}
        self.out_order = []
        self.in_order = []
        self.int_order = []
        self.pin_function = {}
        self.specials = {}

    def add(self, name, entry):
        if name == 'pin':
            entry = entry.items()[0]
            self.addPin(entry[0], entry[1])
        elif name == 'special':
            self.specials.update(entry)
    
    def addPin(self, name, direction):
        self.pin_direction[name] = direction
        if direction == "output":
            self.out_order.append(name)
            self.out_order.sort()
        elif direction == "input":
            self.in_order.append(name)
            self.in_order.sort()
        elif direction == "internal":
            self.int_order.append(name)
            self.int_order.sort()
        else:
            print "WARNING: unsupported pin direction:", direction, "for pin", name, "on gate type", self.name

    def generateC(self):
        output = ""
        # add comments with original bool_exp
        for index, p in enumerate(self.out_order):
            output += "\t//" + p + " : " + self.pin_function[p] + "\n"
            output += "\toutput->array[" + str(index) + "].value = 0;" 
        return output

    def getPinMap(self):
        pm = {}
        counters = { "input" : 0, "output" : 0, "internal" : 0}
        for p in self.pin_direction:
            d = self.pin_direction[p]
            pm[p] = d + "->array[" + str(counters[d]) + "].value"
            counters[d] += 1
        return pm

# TODO: number/order the pins

import itertools

class Gate:
    
    newid = itertools.count().next

    def __init__(self, name):
        self.gid = Gate.newid()
        self.name = name
        self.type = None
        self.ref_pin = {}
        self.in_pins = []
        self.out_pins = []

    def __repr__(self):
        return self.name+"_gate"

    def setType(self, t):
        self.type = t
        self.in_pins = [0] * len(t.in_order)
        self.out_pins = [0] * len(t.out_order)
        if self.type.name == "fanout": 
            self.fan_out = []

    def validateRef(self, ref):
        if ref not in self.ref_pin:
            for r in self.ref_pin:
                if type(ref) is str and isinstance(r, Gate) and r.name == ref:
                    return r 
                if isinstance(ref, Gate) and type(r) is str and ref.name == r:
                    return r
            print "==> ERROR: could not find", ref, "in", self.name
            return None
        else:
            return ref

    def addIORef(self, ref):
        if self.type.name == "fanout":
            print "ERROR(g1): don't use .addIORef on a fanout gate"
            return
        if len(self.in_pins) + len(self.out_pins) > 1:
            print "ERROR(g2): expecting one IO pin"
            return
        if self.type.name == "input_gate":
            self.ref_pin[ref] = "out"
            self.out_pins[0] = ref
        elif self.type.name == "output_gate":
            self.ref_pin[ref] = "in"
            self.in_pins[0] = ref
        else:
            print "ERROR(io): IOref for unknown type:", self.type.name

    def addRef(self, pin, ref):
        self.ref_pin[ref] = pin
        if self.type.name == "fanout" and pin != "in":
            print "ERROR(g3): don't use .addRef on a fanout gate"
            return
        if self.type.pin_direction[pin] == "input":
            self.in_pins[self.type.in_order.index(pin)] = ref
        else:
            self.out_pins[self.type.out_order.index(pin)] = ref

    def updateRef(self, old_ref, new_ref):
        old_ref = self.validateRef(old_ref)
        if old_ref not in self.ref_pin:
            print "ERROR(g4): updating", old_ref, "with", new_ref, "but it doesn't exist in", self.name
            print self.ref_pin
            self.ref_pin[new_ref] = []
            return
        self.ref_pin[new_ref] = self.ref_pin.pop(old_ref)
        if old_ref in self.in_pins:
            self.in_pins[self.in_pins.index(old_ref)] = new_ref
        elif old_ref in self.out_pins:
            self.out_pins[self.out_pins.index(old_ref)] = new_ref
        elif self.type.name == "fanout" and old_ref in self.fan_out:
            print "ALERT: Updating ref in a fanout"
            self.fan_out[self.fan_out.index(old_ref)] = new_ref
            return

    def getRefPin(self, ref):
        ref = self.validateRef(ref)
        if ref not in self.ref_pin: 
            print "ERROR(g5): unknown reference", ref, "for", self.name
            print self.ref_pin
            return None
        return self.ref_pin[ref]

    def getRefDirection(self, ref):
        ref = self.validateRef(ref)
        if ref not in self.ref_pin:
            print "ERROR(g6): unknown reference", ref, "for", self.name
            print self.ref_pin
            return None
        return "input" if ref in self.in_pins else "output"
        # return self.type.pin_direction[self.ref_pin[ref]]

    def addFanOut(self, ref):
        if self.type.name is not "fanout":
            print "ERROR(g7): fanout gate type expected"
            return
        self.ref_pin[ref] = "out"
        self.fan_out.append(ref)

    def getOutIndex(self, ref):
        ref = self.validateRef(ref)
        if ref not in self.ref_pin: 
            print "ERROR(g8): unknown reference", ref, "for", self.name
            print self.ref_pin
            return None
        if self.type.name == "fanout":
            if ref in self.fan_out:
                return 0
        if ref in self.out_pins:
            return self.out_pins.index(ref)
        return -1

# TODO: auto-increment gid's

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
            self.start = r[0]
            self.end = r[1]
        else:
            self.type = 'Single'
            self.value = s.strip('[]')

