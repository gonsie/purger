# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 6, 2012

import ply.lex as lex

reserved = {
    'module' : 'MODULE',
    'endmodule' : 'ENDMODULE',
    'input' : 'INPUT',
    'output' : 'OUTPUT',
}

re_tokens = [
    'SEMI', 'COMMA', 'DOT', 'COLON',
    'BASE', 'SIGN',
    'LPAREN', 'RPAREN',  'LSQUARE', 'RSQUARE',
    'SFLOAT', 'UNSIGNED', 'ID',
]

def create_lexer():

    global reserved
    global tokens
    tokens = re_tokens + list(reserved.values())

    t_SEMI = r';'
    t_LPAREN = r'\('
    t_RPAREN = r'\)'
    t_COMMA = r','
    t_DOT = r'\.'
    t_LSQUARE = r'\['
    t_RSQUARE = r'\]'
    t_COLON = r':'
    t_BASE = r'\'[bBoOdDhH]'
    t_SFLOAT = r'[\+-]?[\d_A-Fa-f]+\.[\d_A-Fa-f]+'
    t_SIGN = r'[\+-]'
    t_UNSIGNED = r'[\d_A-Fa-fXxZz]+'

    def t_ID(t):
        r'[a-zA-Z_][\w$]*|\\[\S]+'
        t.type = reserved.get(t.value, 'ID')  # check for reserved words
        return t

    t_ignore = " \t"

    def t_ignore_COMMENT(t):
        r'//.*\n'
        t.lexer.lineno += 1

    # Define a rule to track line numbers (\n tokens otherwise discarded)
    def t_newline(t):
        r'\n+'
        t.lexer.lineno += len(t.value)

    # Error handling rule
    def t_error(t):
        print "Illegal character '%s'" % t.value[0]
        t.lexer.skip(1)

    return lex.lex(errorlog=lex.NullLogger())


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import ply.yacc as yacc
from time import time
import classes

def create_parser():

    def p_multimodule(t):
        'multimodule : module multimodule'
        t[0] = t[1] + t[2]

    def p_multimodule_e(t):
        'multimodule :'
        t[0] = []

    def p_module(t):
        'module : MODULE ID list_of_ports SEMI module_items ENDMODULE'
        g = classes.Gate_Type(t[2], "mega_gate")
        for p in t[5]:
            g.add(p[0], p[1])
        g.setOrders()
        t[0] = [g]

# LIST_OF_PORTS

    def p_list_of_ports(t):
        'list_of_ports : LPAREN port more_ports RPAREN'
        t[0] = ""
        # I DONT CARE

    def p_list_of_ports_e(t):
        'list_of_ports :'
        pass

    def p_port(t):
        'port : port_expression'
        t[0] = t[1]

    def p_port_dot(t):
        'port : DOT ID LPAREN port_expression RPAREN'
        print "ALERT: using rule p_port_dot"
        t[0] = ('.'+t[2], t[4])

    def p_more_ports(t):
        'more_ports : COMMA port more_ports'
        t[0] = [t[2]]
        if t[3] != None: t[0].extend(t[3])

    def p_more_ports_e(t):
        'more_ports :'
        t[0] = ""

    def p_port_expression(t):
        'port_expression : port_reference'
        t[0] = t[1]

    def p_port_expression_e(t):
        'port_expression :'
        t[0] = ""

    def p_port_reference(t):
        'port_reference : ID range'
        t[0] = ""

# MODULE_ITEMS

    def p_module_items(t):
        'module_items : module_item module_items'
        t[0] = t[1] + t[2]

    def p_module_items_e(t):
        'module_items :'
        t[0] = []

    def wire_enumeration(range_obj, list_of_variables):
        if range_obj.type is 'None':
            return list_of_variables
        output = []
        for i in range_obj.enumeration():
            if type(list_of_variables) is list:
                for v in list_of_variables:
                    output.append(v + "[" + str(i) + "]")
            else:
                output.append(list_of_variables + "[" + str(i) + "]")
        return output

    def p_module_item_inout(t):
        '''module_item : INPUT range list_of_variables SEMI
                       | OUTPUT range list_of_variables SEMI'''
        t[0] = []
        wl = wire_enumeration(t[2], t[3])
        if t[2].type is not 'None':
            if len(t[3]) > 1:
                print "ERROR: multiple multibit in/outs defined at once"
                print "=>", t[1], t[2], t[3], t[4]
            t[0].append( ('multibit', {t[3][0] : {'direction' : t[1], 'width' : len(wl), 'wires' : wl} }) )
        for w in wl:
            t[0].append( ('pin', {w : {'direction' : t[1]}}) )

    def p_list_of_variables(t):
        'list_of_variables : ID more_vars'
        t[0] = [t[1]] + t[2]

    def p_more_vars(t):
        'more_vars : COMMA ID more_vars'
        t[0] = [t[2]] + t[3]

    def p_more_vars_e(t):
        'more_vars :'
        t[0] = []

# NUMBERS

    def p_range_r(t):
        'range : LSQUARE number COLON number RSQUARE'
        t[0] = classes.Range(t[2], t[4])

    def p_range_s(t):
        'range : LSQUARE number RSQUARE'
        t[0] = classes.Range(t[2])

    def p_range_e(t):
        'range :'
        t[0] = classes.Range()

    def p_number_1(t):
        'number : SFLOAT'
        t[0] = float(t[1])

    def p_number_2(t):
        'number : decimal'
        t[0] = t[1]

    def p_decimal(t):
        'decimal : SIGN UNSIGNED'
        t[0] = int(t[1] + t[2])

    def p_unsigned(t):
        'decimal : UNSIGNED'
        t[0] = int(t[1])

    def p_number_base_1(t):
        'number : UNSIGNED BASE UNSIGNED'
        t[0] = int(t[3], base(t[2]))
        # note: t[1] is size of number in memory

    def p_number_base_2(t):
        'number : BASE UNSIGNED'
        t[0] = int(t[2], base(t[1]))

# OTHER FUNCTIONS

    def p_error(t):
        print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno

    return yacc.yacc(tabmodule='ply_verilog_rtl_parsetab')
