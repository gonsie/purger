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
    

    print tokens

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
    t_SFLOAT = r'[\+-]?[\d_]+\.[\d_]+'
    t_SIGN = r'[\+-]'
    t_UNSIGNED = r'[\d_]+'

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

    return lex.lex()


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import ply.yacc as yacc

def create_parser():

    precedence = ()

    # all used IDs
    names = {}

    ### module & gate tracking

    mod_count = 0

    def p_source_text(t):
        'source_text : description'
        t[0] = ('source_text', t[1])

    def p_description(t):
        'description : module'
        t[0] = ('description', t[1])

    def p_module(t):
        'module : MODULE ID list_of_ports SEMI module_items ENDMODULE'
        names[t[2]] = t[2]
        t[0] = ('module', 'module', names[t[2]], t[3], ';', t[5], 'endmodule')

    def p_list_of_ports(t):
        'list_of_ports : LPAREN port more_ports RPAREN'
        t[0] = ('list_of_ports', '(', t[2], t[3], ')')

    def p_list_of_ports_e(t):
        'list_of_ports :'
        t[0] = ('list_of_ports', 'EMPTY')

    def p_port(t):
        'port : port_expression'
        t[0] = ('port', t[1])

    def p_port_dot(t):
        'port : DOT ID LPAREN port_expression RPAREN'
        names[t[2]] = t[2]
        t[0] = ('port', '.', names[t[2]], '(', t[4], ')')

    def p_more_ports(t):
        'more_ports : COMMA port more_ports'
        t[0] = ('more_ports', ',', t[2], t[3])

    def p_more_ports_e(t):
        'more_ports :'
        t[0] = ('more_ports', 'EMPTY')

    def p_port_expression(t):
        'port_expression : port_reference'
        t[0] = ('port_expression', t[1])

    def p_port_expression_e(t):
        'port_expression :'
        t[0] = ('port_expression', 'EMPTY')

    def p_port_reference_1(t):
        'port_reference : ID'
        names[t[1]] = t[1]
        t[0] = ('port_reference', names[t[1]])

    def p_port_reference_2(t):
        'port_reference : ID LSQUARE primary RSQUARE'
        names[t[1]] = t[1]
        t[0] = ('port_reference', names[t[1]], '[', t[3], ']')

    def p_port_reference_3(t):
        'port_reference : ID LSQUARE primary COLON primary RSQUARE'
        names[t[1]] = t[1]
        t[0] = ('port_reference', names[t[1]], '[', t[3], ':', t[5], ']')

    def p_module_items(t):
        'module_items : module_item module_items'
        t[0] = ('module_items', t[1], t[2])

    def p_module_items_e(t):
        'module_items :'
        t[0] = ('module_items', 'EMPTY')

    def p_module_item_input(t):
        'module_item : INPUT range list_of_variables SEMI'
        t[0] = ('module_item', 'input', t[2], t[3], ';')

    def p_module_item_output(t):
        'module_item : OUTPUT range list_of_variables SEMI'
        t[0] = ('module_item', 'output', t[2], t[3], ';')

    def p_module_item_wire(t):
        'module_item : WIRE range list_of_variables SEMI'
        t[0] = ('module_item', 'wire', t[2], t[3], ';')

    def p_module_item_assign(t):
        'module_item : ASSIGN list_of_assignments SEMI'
        t[0] = ('module_item', 'assign', t[2], ';')

    def p_module_item_module(t):
        'module_item : CELL module_instance more_modules SEMI'
        names[t[1]] = t[1]
        t[0] = ('module_item', names[t[1]], t[2], t[3], ';')

    def p_module_instance(t):
        'module_instance : ID LPAREN list_of_module_connections RPAREN'
        names[t[1]] = t[1]
        t[0] = ('module_instance', names[t[1]], '(', t[3], ')')
        global mod_count
        mod_count += 1

    def p_more_modules(t):
        'more_modules : COMMA module_instance more_modules'
        t[0] = ('more_modules', ',', t[2], t[3])

    def p_more_modules_e(t):
        'more_modules :'
        t[0] = ('more_modules', 'EMPTY')

    def p_list_of_module_connections(t):
        'list_of_module_connections : port_connection more_connections'
        t[0] = ('list_of_module_connections', t[1], t[2])

    def p_list_of_module_connections_e(t):
        'list_of_module_connections :'
        t[0] = ('list_of_module_connections', 'EMPTY')

    def p_port_connection(t):
        'port_connection : primary'
        t[0] = ('port_connection', t[1])

    def p_port_connection_dot(t):
        'port_connection : DOT ID LPAREN primary RPAREN'
        names[t[2]] = t[2]
        t[0] = ('port_connection', '.', names[t[2]], '(', t[4], ')')

    def p_port_connection_e(t):
        'port_connection :'
        t[0] = ('port_connection', 'EMPTY')

    def p_more_connections(t):
        'more_connections : COMMA port_connection more_connections'
        t[0] = ('more_connections', ',', t[2], t[3])

    def p_more_connections_e(t):
        'more_connections :'
        t[0] = ('more_connections', 'EMPTY')

    def p_range(t):
        'range : LSQUARE primary COLON primary RSQUARE'
        t[0] = ('range', '[', t[2], ':', t[4], ']')

    def p_range_e(t):
        'range :'
        t[0] = ('range', 'EMPTY')

    def p_list_of_variables(t):
        'list_of_variables : ID more_vars'
        names[t[1]] = t[1]
        t[0] = ('list_of_variables', names[t[1]], t[2])

    def p_more_vars(t):
        'more_vars : COMMA ID more_vars'
        names[t[2]] = t[2]
        t[0] = ('more_vars', ',', names[t[2]])

    def p_more_vars_e(t):
        'more_vars :'
        t[0] = ('more_vars', 'EMPTY')

    def p_list_of_assignments(t):
        'list_of_assignments : assignment more_assignments'
        t[0] = ('list_of_assignments', t[1], t[2])

    def p_more_assignments(t):
        'more_assignments : COMMA assignment more_assignments'
        t[0] = ('more_assignments', ',', t[2], t[3])

    def p_more_assignments_e(t):
        'more_assignments :'
        t[0] = ('more_assignments', 'EMPTY')

    def p_assignment(t):
        'assignment : lvalue EQ primary'
        t[0] = ('assignment', t[1], '=', t[3])

    def p_lvalue_1(t):
        'lvalue : identifier'
        t[0] = ('lvalue', t[1])

    def p_lvalue_2(t):
        'lvalue : identifier LSQUARE primary RSQUARE'
        t[0] = ('lvalue', t[1], '[', t[3], ']')

    def p_lvalue_3(t):
        'lvalue : identifier LSQUARE primary COLON primary RSQUARE'
        t[0] = ('lvalue', t[1], '[', t[3], ':', t[5], ']')

    def p_primary_num(t):
        'primary : number'
        t[0] = ('primary', t[1])

    def p_primary_1(t):
        'primary : identifier'
        t[0] = ('primary', t[1])

    def p_primary_2(t):
        'primary : identifier LSQUARE primary RSQUARE'
        t[0] = ('primary', t[1], '[', t[3], ']')

    def p_primary_3(t):
        'primary : identifier LSQUARE primary COLON primary RSQUARE'
        t[0] = ('primary', t[1], '[', t[3], ':', t[5], ']')

    def p_number_1(t):
        'number : SFLOAT'
        t[0] = ('number', t[1])

    def p_number_2(t):
        'number : decimal'
        t[0] = ('number', t[1])

    def p_decimal(t):
        'decimal : SIGN UNSIGNED'
        t[0] = ('decimal', t[1], t[2])

    def p_unsigned(t):
        'decimal : UNSIGNED'
        t[0] = ('decimal', t[1])

    def p_number_base_1(t):
        'number : UNSIGNED BASE UNSIGNED'
        t[0] = ('number', t[1], t[2], t[3])

    def p_number_base_2(t):
        'number : BASE UNSIGNED'
        t[0] = ('number', t[1], t[2])

    def p_identifier(t):
        'identifier : ID more_ids'
        names[t[1]] = t[1]
        t[0] = ('identifier', names[t[1]], t[2])

    def p_more_ids(t):
        'more_ids : DOT ID more_ids'
        names[t[2]] = t[2]
        t[0] = ('identifier', '.', names[t[2]], t[3])

    def p_more_ids_e(t):
        'more_ids :'
        t[0] = ('more_ids', 'EMPTY')

    def p_error(t):
        print "Syntax error at", t.value, "type", t.type, "on line", t.lexer.lineno
    
    return yacc.yacc(tabmodule='ply_verilog_netlist_parsetab')
