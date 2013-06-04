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

def create_parser(dbname):

    precedence = ()

    cell_tokens = {}
    pin_directions = {}

    def p_library(t):
        'library : LIBRARY LPAR ID RPAR LCURLY attributes RCURLY'
        t[0] = {}
        additional_tables()
        t[0]['cells'] = cell_tokens
        t[0]['pins'] = pin_directions

    def additional_tables():
        stmt = ["" * 3]
        stmt.append("CREATE TABLE input (gid INTEGER PRIMARY KEY, wire_name TEXT);")
        stmt.append("CREATE TABLE output (gid INTEGER PRIMARY KEY, wire_name TEXT);")
        stmt.append("CREATE TABLE gids (gid INTEGER PRIMARY KEY, gate TEXT);")
        # for s in stmt: dbcur.execute(s)
        return ' '.join(stmt)

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
        cell_tokens[t[3]] = 'CELL'
        pin_directions[t[3]] = {}
        s = "CREATE TABLE " + t[3] + " (gid INTEGER PRIMARY KEY, cell_name TEXT, "
        for p in t[6]:
            s += "pin_" + p[0] + " TEXT, "
            pin_directions[t[3]][p[0]] = p[1]
        s = s[:-2] + ");"
        # dbcur.execute(s)

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
