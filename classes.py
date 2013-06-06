class Gate_Type:
    def __init__(self, name):
        self.name = name
        self.pins = {}
    
    def addPin(self, name, direction):
        self.pins[name] = direction

# TODO: number/order the pins

class Gate:
    def __init__(self, name):
        self.name = name
        self.type = None
        self.pin_direction = {}
        self.ref_pin = {}

    def setType(self, t):
        self.type = t.name
        self.pin_direction = t.pins.copy()
        if self.type is "fanout": self.outputs = []

    def addIORef(self, ref):
        if len(self.pin_direction) > 1:
            print "ERROR: expecting one pin"
            return
        p = self.pin_direction.keys()[0]
        self.ref_pin[ref] = [p, self.pin_direction[p]]

    def addRef(self, pin, ref):
        self.ref_pin[ref] = [pin, self.pin_direction[pin]]

    def updateRef(self, old_ref, new_ref):
        if old_ref not in self.ref_pin: self.ref_pin[new_ref] = []; return
        self.ref_pin[new_ref] = self.ref_pin.pop(old_ref)

    def getRefPin(self, ref):
        if ref not in self.ref_pin: return None
        return self.ref_pin[ref][0]

    def getRefDirection(self, ref):
        if ref not in self.ref_pin: return None
        return self.ref_pin[ref][1]

    def addFanOut(self, g):
        if self.type is not "fanout":
            print "ERROR: fanout gate type expected"
            return
        self.outputs.append(g)

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

