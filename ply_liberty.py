# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 8, 2012

import ply.lex as lex

reserved = {
    'library' : 'LIBRARY',
    'define' : 'DEFINE',
    'define_group' : 'DEFINE_GROUP',
    'cell' : 'CELL',
    'pin' : 'PIN',
    'direction' : 'DIRECTION',
    'input' : 'IO_DIR',
    'output' : 'IO_DIR',
}

tokens = [
    'PLUS', 'MINUS', 'MULT', 'DIV', 'EQ',
    'COMMA', 'SEMI', 'COLON',
    'LPAR', 'RPAR', 'LCURLY', 'RCURLY', 
    'NUM', 'STR', 'ID',
] + list(reserved.values())

def create_lexer():

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

    return lex.lex()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import ply.yacc as yacc
import classes

def create_parser():

    precedence = ()

    gate_types = {}

    def p_library(t):
        'library : LIBRARY LPAR ID RPAR LCURLY attributes RCURLY'
        t[0] = {}
        additional_types()
        t[0] = gate_types

    def additional_types():
        gi = classes.Gate_Type("input_gate")
        gi.addPin("out", "output")
        go = classes.Gate_Type("output_gate")
        go.addPin("in", "input")
        gw = classes.Gate_Type("fanout")
        gw.addPin("in", "input")
        gw.addPin("out", "output")
        gate_types[gi.name] = gi
        gate_types[go.name] = go
        gate_types[gw.name] = gw

    def p_attributes(t):
        'attributes : attribute attributes'
        t[0] = t[1] + t[2]

    def p_attributes_e(t):
        'attributes :'
        t[0] = []

    def p_attribute(t):
        '''attribute : simple_attribute
                     | complex_attribute
                     | named_attribute'''
        t[0] = t[1]

    def p_simple_attribute(t):
        '''simple_attribute : ID COLON STR
                            | ID COLON ID
                            | ID COLON NUM'''
        t[0] = []

    def p_simple_attribute_semi(t):
        '''simple_attribute : ID COLON STR SEMI
                            | ID COLON ID SEMI
                            | ID COLON NUM SEMI'''
        t[0] = []

    def p_complex_attribute(t):
        'complex_attribute : ID LPAR arg args RPAR group_or_not'
        t[0] = []

    def p_named_attribute_cell(t):
        'named_attribute : CELL LPAR ID RPAR LCURLY attributes RCURLY'
        t[0] = []
        g = classes.Gate_Type(t[3])
        for p in t[6]:
            g.addPin(p[0], p[1])
        gate_types[g.name] = g

    def p_named_attribute_pin(t):
        'named_attribute : PIN LPAR ID RPAR LCURLY attributes RCURLY'
        t[0] = [(t[3], t[6][0])]

    def p_named_attribute_direction(t):
        '''named_attribute : DIRECTION COLON IO_DIR
                           | DIRECTION COLON IO_DIR SEMI'''
        t[0] = [t[3]]

    def p_arg(t):
        '''arg : STR
               | NUM
               | ID'''
        t[0] = t[1]

    def p_arg_e(t):
        'arg :'
        t[0] = ""

    def p_args(t):
        'args : COMMA arg args'
        t[0] = ", " + t[2] + t[3]

    def p_args_e(t):
        'args :'
        t[0] = ""

    def p_group_or_not_not(t):
        'group_or_not : SEMI'
        t[0] = ""

    def p_group_or_not_group(t):
        'group_or_not : LCURLY attributes RCURLY'
        t[0] = t[2]

    def p_error(t):
        print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno

    return yacc.yacc(tabmodule='ply_liberty_parsetab')
