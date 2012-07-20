# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# June 6, 2012

import ply.lex as lex

reserved = {
    'module' : 'MODULE',
    'endmodule' : 'ENDMODULE',
    'input' : 'INPUT',
    'output' : 'OUTPUT',
    'wire' : 'WIRE',
    'assign' : 'ASSIGN',
}

re_tokens = [
    'SEMI', 'COMMA', 'DOT', 'COLON',
    'EQ', 'BASE', 'SIGN',
    'LPAREN', 'RPAREN',  'LSQUARE', 'RSQUARE',
    'SFLOAT', 'UNSIGNED', 'ID',
]

def create_lexer(nets={}):

    global reserved
    reserved.update(nets)

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
    t_EQ = r'\='
    t_BASE = r'\'[bBoOdDhH]'
    t_SFLOAT = r'[\+-]?[\d_A-Fa-f]+\.[\d_A-Fa-f]+'
    t_SIGN = r'[\+-]'
    t_UNSIGNED = r'[\d_A-Fa-fXxZz]+'

    def t_ID(t):
        r'[a-zA-Z_][\w$]*|\\[\S]+'
        t.type = reserved.get(t.value, 'ID')  # check for reserved words
        return t

    t_ignore = " \t"

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
import netlist

def create_parser():

    precedence = ()

    def p_module(t):
        'module : MODULE ID list_of_ports SEMI module_items ENDMODULE'
        t[0] = netlist.Module(t[2], t[3], t[5])

    def p_list_of_ports_e(t):
        'list_of_ports :'
        pass

    def p_list_of_ports(t):
        'list_of_ports : LPAREN port more_ports RPAREN'
        t[0] = [t[2]]
        if t[3] != None:
            t[0].extend(t[3])

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
        if t[3] != None:
            t[0].extend(t[3])

    def p_more_ports_e(t):
        'more_ports :'
        pass

    def p_port_expression(t):
        'port_expression : port_reference'
        t[0] = t[1]

    def p_port_expression_e(t):
        'port_expression :'
        pass

    def p_port_reference(t):
        'port_reference : ID range'
        t[0] = netlist.Wire(t[1], t[2])

    def p_module_items(t):
        'module_items : module_item module_items'
        t[0] = t[1]
        if t[2] != None:
            t[0].extend(t[2])

    def p_module_items_e(t):
        'module_items :'
        pass

    def p_module_item_vars(t):
        '''module_item : INPUT range list_of_variables SEMI
                       | OUTPUT range list_of_variables SEMI
                       | WIRE range list_of_variables SEMI'''
        t[0] = []
        for v in t[3]:
            if v != None:
                t[0].append((t[1], netlist.Wire(v, t[2])))

    def p_module_item_assign(t):
        'module_item : ASSIGN list_of_assignments SEMI'
        t[0] = []
        for v in t[2]:
            t[0].append(v)

    def p_module_item_module(t):
        'module_item : CELL module_instance more_modules SEMI'
        t[2].set_type(t[1])
        t[0] = [t[2]]
        if t[3] != None:
            for m in t[3]:
                m.set_type(t[1])
                t[0].append(m)

    def p_module_instance(t):
        'module_instance : ID LPAREN list_of_module_connections RPAREN'
        t[0] = netlist.Net(t[1], t[3])

    def p_more_modules(t):
        'more_modules : COMMA module_instance more_modules'
        t[0] = [t[2]]
        if t[3] != None:
            t[0].extend(t[3])

    def p_more_modules_e(t):
        'more_modules :'
        pass

    def p_list_of_module_connections(t):
        'list_of_module_connections : port_connection more_connections'
        if t[1] != None:
            t[0] = [t[1]]
            if t[2] != None:
                t[0].extend(t[2])

    def p_list_of_module_connections_e(t):
        'list_of_module_connections :'
        pass

    def p_port_connection(t):
        'port_connection : primary'
        t[0] = t[1]

    def p_port_connection_dot(t):
        'port_connection : DOT ID LPAREN primary RPAREN'
        t[0] = {t[1]+t[2] : t[4]}

    def p_port_connection_e(t):
        'port_connection :'
        pass

    def p_more_connections(t):
        'more_connections : COMMA port_connection more_connections'
        if t[2] != None:
            t[0] = [t[2]]
            if t[3] != None:
                t[0].extend(t[3])

    def p_more_connections_e(t):
        'more_connections :'
        pass

    def p_list_of_variables(t):
        'list_of_variables : ID more_vars'
        t[0] = [t[1]]
        if t[2] != None:
            t[0].extend(t[2]) 

    def p_more_vars(t):
        'more_vars : COMMA ID more_vars'
        t[0] = [t[2]]
        if t[3] != None:
            t[0].extend(t[3])

    def p_more_vars_e(t):
        'more_vars :'
        pass

    def p_list_of_assignments(t):
        'list_of_assignments : assignment more_assignments'
        t[0] = [t[1]]
        if t[2] != None:
            t[0].extend(t[2])

    def p_more_assignments(t):
        'more_assignments : COMMA assignment more_assignments'
        t[0] = [t[2]]
        if t[3] != None:
            t[0].extend(t[3])

    def p_more_assignments_e(t):
        'more_assignments :'
        pass

    def p_assignment(t):
        'assignment : primary EQ primary'
        t[0] = {t[1] : t[3]}

    def p_primary_num(t):
        'primary : number'
        t[0] = t[1]

    def p_primary(t):
        'primary : identifier range'
        t[0] = netlist.Wire(t[1], t[2])

    def p_range_r(t):
        'range : LSQUARE number COLON number RSQUARE'
        t[0] = netlist.Range(t[2], t[4])

    def p_range_s(t):
        'range : LSQUARE number RSQUARE'
        t[0] = netlist.Range(t[2])

    def p_range_e(t):
        'range :'
        t[0] = netlist.Range()

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

    # the 'more_ids' are continuation of same identifier
    def p_identifier(t):
        'identifier : ID more_ids'
        t[0] = t[1] + t[2]

    def p_more_ids(t):
        'more_ids : DOT ID more_ids'
        t[0] = "." + t[2] + t[3]

    def p_more_ids_e(t):
        'more_ids :'
        t[0] = ""

    def p_error(t):
        print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno
    
    def base(s):
        base = -1
        if s == "'b" or s == "'B":
            base = 2
        elif s == "'o" or s == "'O":
            base = 8
        elif s == "'d" or s == "'D":
            base = 10
        elif s == "'h" or s == "'H":
            base = 16
        return base

    return yacc.yacc(tabmodule='ply_verilog_netlist_parsetab')
