# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# July 9, 2012

reserved = {}

re_tokens = [
	'NOT_B', 'NOT_A', 'XOR', 'AND', 'OR', 'ONE', 'ZERO', 'ID',
]

pinmap = {}

import ply.lex as lex
def create_lexer(pins={}, pin_map={}):

	global pinmap
	pinmap = pin_map

	global reserved
	reserved.update(pins)

	global tokens
	tokens = re_tokens + list(reserved.values())
	if len(pins) is 0:
		tokens.append('PIN')

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

	return lex.lex(errorlog=lex.NullLogger())

import ply.yacc as yacc
def create_parser():

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
		t[0] = pinmap[t[1]]

	def p_error(t):
	    print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno

	return yacc.yacc(tabmodule='ply_boolean_expressions_parsetab')
