# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 8, 2012


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

cell_types = []
pin_atts = []
in_pin = False

class Cell:
    def __init__(self, name):
        self.name = name[1]
        print "new cell type:", name
    
    def __repr__(self):
        return self.name

def p_library(t):
    'library : LIBRARY LPAR ID RPAR LCURLY attributes RCURLY'
    t[0] = ('library', 'library', '(', t[3], ')', '{', t[6], '}')

def p_attributes(t):
    'attributes : attribute attributes'
    t[0] = ('attributes', t[1], t[2])

def p_attributes_e(t):
    'attributes :'
    t[0] = ('attributes', 'EMPTY')

def p_attribute(t):
    '''attribute : simple_attribute
                 | complex_attribute'''
    t[0] = ('attribute', t[1])

def p_simple_attribute(t):
    '''simple_attribute : ID COLON STR
                        | ID COLON ID
                        | ID COLON NUM'''
    t[0] = ('simple_attribute', t[1], ':', t[3])

def p_simple_attribute_semi(t):
    '''simple_attribute : ID COLON STR SEMI
                        | ID COLON ID SEMI
                        | ID COLON NUM SEMI'''
    t[0] = ('simple_attribute', t[1], ':', t[3], ';')

def p_complex_attribute(t):
    'complex_attribute : ID LPAR arg args RPAR group_or_not'
    t[0] = ('complex_attribute', t[1], '(', t[3], t[4], ')', t[6])
    if t[1] == 'cell':
        c = Cell(t[3])
        cell_types.append(c)
    elif t[1] == 'pin':
        in_pin = True
        pin_atts.append(t[3][1])

def p_arg(t):
    '''arg : STR
           | NUM
           | ID'''
    t[0] = ('arg', t[1])

def p_arg_e(t):
    'arg :'
    t[0] = ('arg', 'EMPTY')

def p_args(t):
    'args : COMMA arg args'
    t[0] = ('args', ',', t[2], t[3])

def p_args_e(t):
    'args :'
    t[0] = ('args', 'EMPTY')

def p_group_or_not_not(t):
    'group_or_not : SEMI'
    t[0] = ('group_or_not', ';')

def p_group_or_not_group(t):
    'group_or_not : LCURLY attributes RCURLY'
    t[0] = ('group_or_not', '{', t[2], '}')

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
    tree = yacc.parse(a)
#    print tree
#    dot_convert(tree)
    print cell_types
    print pin_atts
