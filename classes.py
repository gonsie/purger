class gate_type:
    def __init__(self, name):
        self.name = name
        self.pins = {}
    
    def addPin(self, name, direction):
        self.pins[name] = direction

# TODO: number/order the pins

class gate:
    def __init__(self, name):
        self.name = name
        self.type = None
        self.pin_direction = {}
        self.ref_pin = {}

    def setType(self, t):
        self.type = t.name
        self.pin_direction = t.pins.copy()
        if self.type is "fanout": self.outputs = []

    def addRef(self, pin, ref):
        self.ref_pin[ref] = [pin, self.pin_direction[pin]]

    def updateRef(self, old_ref, new_ref):
        self.ref_pin[new_ref] = self.ref_pin.pop(old_ref)

    def getRefPin(self, ref):
        return self.ref_pin[ref][0]

    def getRefDirection(self, ref):
        return self.ref_pin[ref][1]

    def addFanOut(self, g):
        if self.type is not "fanout":
            print "ERROR: fanout gate type expected"
            return
        self.outputs.append(g)

# TODO: auto-increment gid's
