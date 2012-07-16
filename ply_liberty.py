# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 8, 2012

import ply.lex as lex

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
]

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
import liberty

def create_parser():
    precedence = ()

    # all used IDs
    names = {}

    def p_library(t):
        'library : LIBRARY LPAR ID RPAR LCURLY attributes RCURLY'
        #t[0] = ('library', 'library', '(', t[3], ')', '{', t[6], '}')
        t[0] = liberty.Lib(t[3], t[6])

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
        t[0] = liberty.Att(t[1])
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

    return yacc.yacc()