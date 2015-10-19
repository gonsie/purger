# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# July 9, 2012

# reserved.update() is never used because this is empty!
reserved = {}

re_tokens = [
	'NOT_B', 'NOT_A', 'XOR', 'AND', 'OR', 'ONE', 'ZERO', 'ID',
	'LPAR', 'RPAR',
]

# Mapping of pin name to C code name, i.e.
# { A : inputs[0], B : inputs[1], Z : outputs[0] }
pinmap = {}

import ply.lex as lex
def create_lexer(pin_map={}):

	global pinmap
	pinmap = pin_map

	global reserved
	reserved = { k : 'PIN' for k in pin_map.keys() }

	global tokens
	tokens = re_tokens + list(reserved.values())
	if 'PIN' not in tokens:
		tokens.append('PIN')

	t_NOT_A = r'\''
	t_NOT_B = r'\!'
	t_XOR = r'\^'
	t_AND = r'\*|\&'
	t_OR = r'\+|\|'
	t_ONE = r'1'
	t_ZERO = r'0'
	t_LPAR = r'\('
	t_RPAR = r'\)'

	def t_ID(t):
		r'[a-zA-Z][a-zA-Z0-9]*|\\\"[0-9][^\"]*\\\"'
		if reserved.get(t.value, 'ID') != 'PIN':
			print "ERROR: unknown Pin", t.value
			return
		else:
			t.type = 'PIN'
		return t

	t_ignore = " \t\n"

	def t_newline(t):
		r'\n+|\\\n+'
		t.lexer.lineno += len(t.value)

	def t_error(t):
	    print "Illegal character '", t.value[0], "' at", t.lexer.lineno
	    t.lexer.skip(1)

	return lex.lex(errorlog=lex.NullLogger())

import ply.yacc as yacc
def create_parser():

	precedence = (
		('left', 'OR'),
		('left', 'AND'),
		('left', 'XOR'),
		('right', 'NOT_A', 'NOT_B'),
	)

	def p_many(t):
		'expression : expression expression %prec AND'
		if t[2] != None:
			t[0] = t[1] + " && " + t[2]
		else:
			t[0] = t[1]

	def p_exp_or(t):
		'expression : expression OR expression'
		t[0] = t[1] + " || " + t[3]

	def p_exp_and(t):
	    'expression : expression AND expression'
	    t[0] = t[1] + " && " + t[3]

	def p_exp_xor(t):
	 	'expression : expression XOR expression'
		t[0] = "((" + t[1] + " || " + t[3] + ") && !(" + t[1] + " && " + t[3] + "))"

	def p_unary_not(t):
		'expression : expression NOT_A'
		t[0] = "!" + t[1]

	def p_not_unary(t):
		'expression : NOT_B expression'
		t[0] = "!" + t[2]

	def p_unary_s(t):
		'expression : factor'
		t[0] = t[1]

	def p_factor_01(t):
		'''factor : ONE
				  | ZERO'''
		t[0] = t[1]

	def p_factor_pin(t):
		'''factor : PIN
		   		  | ID'''
		t[0] = pinmap[t[1]]

	def p_factor_paren(t):
		'factor : LPAR expression RPAR'
		t[0] = "(" + t[2] + ")"

	def p_error(t):
	    print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno

	return yacc.yacc(tabmodule='ply_boolean_expressions_parsetab')

def update(pin_map):
	global pinmap
	pinmap = pin_map

	global reserved
	reserved = { k : 'PIN' for k in pin_map.keys() }

	global tokens
	tokens = re_tokens + list(reserved.values())
	if 'PIN' not in tokens:
		tokens.append('PIN')
