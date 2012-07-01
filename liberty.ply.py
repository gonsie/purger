# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 8, 2012

import datetime

# Set up a logging object
import logging
logging.basicConfig(level = logging.DEBUG, filename = "parselog.txt",
    filemode = "w", format = "%(filename)10s:%(lineno)4d:%(message)s"
)
log = logging.getLogger()


reserved = {
    'library' : 'LIBRARY',

    'define' : 'DEFINE',
    'define_group' : 'DEFINE_GROUP',
}

tokens = [
    'PLUS', 'MINUS', 'MULT', 'DIV', 'EQ',
    'COMMA', 'SEMI', 'COLON',
    'LPAR', 'RPAR', 'LCURLY', 'RCURLY', 
    'NUM', 'STR', 'ID',
] + list(reserved.values())

t_PLUS = r'\+'
t_MINUS = r'-'
t_MULT = r'\*'
t_DIV = r'/'
t_COMMA = r','
t_SEMI = r';[ \t;]*'
t_LPAR = r'\('
t_RPAR = r'\)'
t_EQ = r'\='
t_LCURLY = r'\{'
t_RCURLY = r'\}[ \t]*;?'
t_COLON = r'[ \t]?:'
t_NUM = r'[-+]?([0-9]+\.?[0-9]*([Ee][-+]?[0-9]+)?|[0-9]*\.[0-9]*([Ee][-+]?[0-9]+)?)'

def t_STR(t):
    r'"[^"]*"'
    t.value = t.value[1:-1]
    return t

def t_ID(t):
    r'[a-zA-Z_][\w$]*[\']?|\\[\S]'
    t.type = reserved.get(t.value, 'ID')  # check for reserved words
    return t

t_ignore = " \t\r"

def t_ignore_COMMENT(t):
    r'/\*([^*]|\*+[^/*])*\*+/'
    pass

# Define a rule to track line numbers (\n tokens otherwise discarded)
def t_newline(t):
    r'\n+|\\\n+'
    t.lexer.lineno += len(t.value)

# Error handling rule
def t_error(t):
    print "Illegal character '", t.value[0], "' at", t.lexer.lineno
    t.lexer.skip(1)

# Build the lexer
import ply.lex as lex
lex.lex()
#debug=True, debuglog=log)

# # # # # # # # # #

precedence = ()

# all used IDs
names = {}

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



def p_library(t):
    'library : LIBRARY LPAR ID RPAR LCURLY attributes RCURLY'
    #t[0] = ('library', 'library', '(', t[3], ')', '{', t[6], '}')
    t[0] = Lib(t[3], t[6])

def p_attributes(t):
    'attributes : attribute attributes'
    t[0] = [t[1]]
    if t[2] != None:
        t[0].extend(t[2])

def p_attributes_e(t):
    'attributes :'
    pass

def p_attribute(t):
    '''attribute : simple_attribute
                 | complex_attribute'''
    t[0] = t[1]

def p_simple_attribute(t):
    '''simple_attribute : ID COLON STR
                        | ID COLON ID
                        | ID COLON NUM'''
    t[0] = Att(t[1])
    t[0].set_simple(t[3])

def p_simple_attribute_semi(t):
    '''simple_attribute : ID COLON STR SEMI
                        | ID COLON ID SEMI
                        | ID COLON NUM SEMI'''
    t[0] = Att(t[1])
    t[0].set_simple(t[3])

def p_complex_attribute(t):
    'complex_attribute : ID LPAR arg args RPAR group_or_not'
    a = [t[3]]
    if t[4] != None:
        a.extend(t[4])
    t[0] = Att(t[1])
    if t[6] != None:
        t[0].set_group(a, t[6])
    else:
        t[0].set_complex(a)

def p_arg(t):
    '''arg : STR
           | NUM
           | ID'''
    t[0] = t[1]

def p_arg_e(t):
    'arg :'
    pass

def p_args(t):
    'args : COMMA arg args'
    t[0] = [t[1]]
    if t[2] != None:
        t[0].extend(t[2])

def p_args_e(t):
    'args :'
    pass

def p_group_or_not_not(t):
    'group_or_not : SEMI'
    t[0] = None

def p_group_or_not_group(t):
    'group_or_not : LCURLY attributes RCURLY'
    t[0] = [t[2]]

def p_error(t):
    print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno


# build parser
import ply.yacc as yacc
yacc.yacc()
#debug=True, debuglog=log)

# # # # # # # # # #

import sys
if len(sys.argv) == 1:
    print "Usage:", sys.argv[0], "filename"
else:
    f = open(sys.argv[1], 'r')
    a = f.read()
    f.close()
    lib = yacc.parse(a)
    for c in lib.cells:
        cell = lib.cells[c]
        print c
        ocount = 0
        icount = 0
        for p in cell.pins:
            pin = cell.pins[p]
            if pin.atts['direction'].value == 'output':
                print "\t", p, "\t", pin.atts['function']
                ocount += 1
            else:
                icount += 1
        print "\t", icount, "inputs and", ocount, "outputs"
    lib.generate_c()
