# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# July 9, 2012

reserved = {
	'A' : 'PIN',
	'B' : 'PIN',
	'Z' : 'PIN', 
}

pin_map = {
	'A' : 'inputs[0]',
	'B' : 'inputs[1]',
	'Z' : 'outputs[0]',
}

tokens = [
	'NOT_B', 'NOT_A', 'XOR', 'AND', 'OR', 'ONE', 'ZERO', 'ID',
] + list(reserved.values())

t_NOT_A = r'\''
t_NOT_B = r'\!'
t_XOR = r'\^'
t_AND = r'\*|\&|[ ]'
t_OR = r'\+|\|'
t_ONE = r'1'
t_ZERO = r'0'

def t_ID(t):
	r'[a-zA-Z][a-zA-Z0-9]*|\\\"[0-9][^\"]*\\\"'
	if reserved.get(t.value, 'ID') != 'PIN':
		print "ERROR: unknown Pin", t.value
		return
	else:
		t.type = 'PIN'
	return t

def t_newline(t):
	r'\n+|\\\n+'
	t.lexer.lineno += len(t.value)

def t_error(t):
    print "Illegal character '", t.value[0], "' at", t.lexer.lineno
    t.lexer.skip(1)

import ply.lex as lex
lex.lex()

precedence = (
	('left', 'OR'),
	('left', 'AND'),
	('left', 'XOR'),
	('left', 'NOT_A', 'NOT_B'),
)

def p_many(t):
	'expressions : expression expressions'
	t[0] = t[1]
	if t[2] != None:
		t[0] += "\n" + t[2]

def p_empty(t):
	'expressions :'
	pass

def p_expression(t):
	'expression : bool'
	t[0] = t[1]

def p_bool(t):
	'bool : bool OR join'
	t[0] = t[1] + " || " + t[3]

def p_bool_s(t):
	'bool : join'
	t[0] = t[1]

def p_join(t):
	'join : join AND expr'
	t[0] = t[1] + " && " + t[3]

def p_join_s(t):
	'join : expr'
	t[0] = t[1]

def p_expr(t):
	'expr : expr XOR unary'
	t[0] = "((" + t[1] + " || " + t[3] + ") && !(" + t[1] + " && " + t[3] + "))"

def p_expr_s(t):
	'expr : unary'
	t[0] = t[1]

def p_unary_not(t):
	'unary : unary NOT_A'
	t[0] = "!" + t[1]

def p_not_unary(t):
	'unary : NOT_B unary'
	t[0] = "!" + t[2]

def p_unary_s(t):
	'unary : factor'
	t[0] = t[1]

def p_factor_01(t):
	'''factor : ONE
			  | ZERO'''
	t[0] = t[1]

def p_factor_pin(t):
	'factor : PIN'
	t[0] = pin_map[t[1]]

def p_error(t):
    print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno


# build parser
import ply.yacc as yacc
yacc.yacc()

import sys
if len(sys.argv) == 1:
    print "Usage:", sys.argv[0], "filename"
else:
    f = open(sys.argv[1], 'r')
    a = f.read()
    f.close()
    c_expr = yacc.parse(a)
    print c_expr