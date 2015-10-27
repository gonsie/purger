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
    'LPAREN', 'RPAREN',  'LSQUARE', 'RSQUARE', 'LCURLY', 'RCURLY',
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
    t_LCURLY = r'\{'
    t_RCURLY = r'\}'
    t_COLON = r':'
    t_EQ = r'\='
    t_BASE = r'\'[bBoOdDhH]'
    t_SFLOAT = r'[\+-]?[\d_A-Fa-f]+\.[\d_A-Fa-f]+'
    t_SIGN = r'[\+-]'
    t_UNSIGNED = r'[\d_A-Fa-fXxZz]+'

    # NOTE: functionally defined tokens are added first
    #       in the same order in which they are defined

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

def create_parser(gate_types, gid=0):

    all_wires = {}
    all_cells = {}

    precedence = ()

    # gid = 0

    def p_module(t):
        'module : MODULE ID list_of_ports SEMI module_items ENDMODULE'
        t[0] = {}
        t[0]['wires'] = all_wires
        t[0]['gates'] = all_cells
        t[0]['obj'] = classes.Module(t[2])
        t[0]['obj'].connections(all_cells)
        t[0]['obj'].pkl()

# LIST_OF_PORTS

    def p_list_of_ports(t):
        'list_of_ports : LPAREN port more_ports RPAREN'
        t[0] = ""

    def p_list_of_ports_e(t):
        'list_of_ports :'
        t[0] = ""

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
        t[0] = ""

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
        t[0] = ""
        wl = wire_enumeration(t[2], t[3])
        if t[2].type is not 'None':
            if len(t[3]) > 1:
                print "ERROR: multiple multibit in/outs defined at once"
                print "=>", t[1], t[2], t[3], t[4]
            all_wires[t[3][0]] = ["multibit_flag", wl]
        # import pdb; pdb.set_trace()
        for w in wl:
            g = classes.Gate("io_cell_" + w)
            g.setType(gate_types[t[1]+"_gate"])
            p = "out" if t[1] == "input" else "in"
            g.addRef(p, w)
            all_cells[g.name] = g
            all_wires[w] = [g]

    def p_module_item_wire(t):
        'module_item : WIRE range list_of_variables SEMI'
        t[0] = ""
        wl = wire_enumeration(t[2], t[3])
        if t[2].type is not 'None':
            if len(t[3]) > 1:
                print "ERROR: multiple multibit wires defined at once"
                print "=>", t[1], t[2], t[3], t[4]
            all_wires[t[3][0]] = ["multibit_flag", wl]
        for w in wl:
            all_wires[w] = []

    def p_module_item_assign(t):
        'module_item : ASSIGN list_of_assignments SEMI'
        t[0] = ""

    def p_module_item_module_local_instantiation(t):
        '''module_item : CELL ID LPAREN list_of_module_connections RPAREN SEMI
                       | MEGACELL ID LPAREN list_of_module_connections RPAREN SEMI'''
        t[0] = ""
        if t[1] not in gate_types:
            raise Exception("Could not find megacell gate type " + t[1])
        g = classes.Gate(t[2])
        g.setType(gate_types[t[1]])
        for p in t[4]:
            if type(p[1]) is str:
                if 'multibit_flag' in all_wires[p[1]]:
                    g.addRef(p[0], all_wires[p[1]][1], True)
                    for w in all_wires[p[1]][1]:
                        all_wires[w].append(g)
                else:
                    g.addRef(p[0], p[1])
                    all_wires[p[1]].append(g)
            elif type(p[1]) is int:
                g.addConstRef(p[0], p[1])
            else:
                enum_p = []
                for q in p[1]:
                    if q in all_wires and 'multibit_flag' in all_wires[q]:
                        enum_p += all_wires[q][1]
                    else:
                        enum_p.append(q)
                g.addRef(p[0], enum_p, True)
                for q in enum_p:
                    if type(q) is str:
                        all_wires[q].append(g)
        all_cells[g.name] = g

    def p_module_item_module_routing(t):
        'module_item : SUBMODULE ID LPAREN list_of_module_connections RPAREN SEMI'
        # scan ID to see if this is going to a particular instance
        # lookup routing, and connect wires?
        t[0] = ""
        for p in t[4]:
            if type(p[1]) is str:
                if 'multibit_flag' in all_wires[p[1]]:
                    for i, w in enumerate(all_wires[p[1]][1]):
                        x = classes.Routing_Object(t[1], t[2], p[0], w, i)
                        all_wires[w].append(x)
                    # print "SUBMODULE multibit connection detected", p[1]
                else:
                    x = classes.Routing_Object(t[1], t[2], p[0], p[1])
                    all_wires[p[1]].append(x)
                    # print "SUBMODULE direct connection detected", p[1]
            elif type(p[1]) is int:
                # x = classes.Routing_Object(t[1], t[2], p[0], w)
                print "SUBMODULE constant value detected", p[1], "line", t.lexer.lineno
                continue
            else:
                enum_p = []
                for q in p[1]:
                    if q in all_wires and 'multibit_flag' in all_wires[q]:
                        enum_p += all_wires[q][1]
                    else:
                        enum_p.append(q)
                for i, q in enumerate(enum_p):
                    if type(q) is str:
                        x = classes.Routing_Object(t[1], t[2], p[0], q, i)
                        all_wires[q].append(x)
                # print "SUBMODULE list detected", p[1]

    def p_module_item_module_list(t):
        'module_item : CELL module_instance more_modules SEMI'
        t[0] = ""
        if len(t[3]) > 0: print "ERROR: multiple module definitions for one cell type"
        print "ERROR: multiple module definition rule for no reason"

# MORE_MODULES / CELLS / CONNECTING PORTS

    def p_module_instance(t):
        'module_instance : ID LPAREN list_of_module_connections RPAREN'
        t[0] = ""
        print "ERROR: module_instance rule being called"

    def p_more_modules(t):
        'more_modules : COMMA module_instance more_modules'
        t[0] = ""
        print "ERROR: using list of module instances"

    def p_more_modules_e(t):
        'more_modules :'
        t[0] = ""

    def p_list_of_module_connections(t):
        'list_of_module_connections : port_connection more_connections'
        t[0] = t[1] + t[2]

    def p_list_of_module_connections_e(t):
        'list_of_module_connections :'
        t[0] = []

    def p_port_connection(t):
        'port_connection : primary'
        print "Warning: Weird primary port connection"
        t[0] = t[1]

    def p_port_connection_dot(t):
        'port_connection : DOT ID LPAREN primary RPAREN'
        if type(t[4]) is str and t[4].find(':') != -1:
            print "Warning: multibit wire as port connection", t[4]
            range_obj = classes.Range()
            x = t[4].split('[')
            range_obj.parse_string(x[-1])
            wl = wire_enumeration(range_obj, x[0])
            t[0] = [(t[2], wl)]
        else:
            t[0] = [(t[2], t[4])]

    def p_port_connection_curly(t):
        'port_connection : DOT ID LPAREN LCURLY list_of_primaries RCURLY RPAREN'
        # many wires connecting to a single multibit pin
        # print "ALERT: Multibit construction"
        t[0] = [(t[2], t[5])]

    def p_port_connection_e(t):
        'port_connection :'
        t[0] = []

    def p_more_connections(t):
        'more_connections : COMMA port_connection more_connections'
        t[0] = t[2] + t[3]

    def p_more_connections_e(t):
        'more_connections :'
        t[0] = []

    def p_list_of_variables(t):
        'list_of_variables : ID more_vars'
        t[0] = [t[1]] + t[2]

    def p_more_vars(t):
        'more_vars : COMMA ID more_vars'
        t[0] = [t[2]] + t[3]

    def p_more_vars_e(t):
        'more_vars :'
        t[0] = []

# ASSIGNMENTS

    def p_list_of_assignments(t):
        'list_of_assignments : assignment more_assignments'
        t[0] = [t[1]]
        if t[2] != None: t[0].extend(t[2])

    def p_more_assignments(t):
        'more_assignments : COMMA assignment more_assignments'
        t[0] = [t[2]]
        if t[3] != None: t[0].extend(t[3])

    def p_more_assignments_e(t):
        'more_assignments :'
        pass

    def p_assignment(t):
        'assignment : primary EQ primary'
        if t[1] in all_wires and t[3] in all_wires:
            ## TODO: make a fannout cell!
            flag = False
            if "io_cell_"+t[3] in all_cells:
                flag = True
                all_wires[t[1]].append(all_cells["io_cell_"+t[3]])
                all_cells["io_cell_"+t[3]].addIORef(t[1])
                all_wires.pop(t[3])
            if "io_cell_"+t[1] in all_cells:
                if flag: print "ALERT: io_cell assigned to io_cell"
                all_wires[t[3]].append(all_cells["io_cell_"+t[1]])
                all_cells["io_cell_"+t[1]].addIORef(t[3])
                all_wires.pop(t[1])
        else:
            if "io_cell_"+t[1] in all_cells:
                all_cells["io_cell_"+t[1]].setAssign(t[3])
                all_wires.pop(t[1])
            else:
                print "ERROR: constant assign stmt without io cell:", t[1], "=", t[3]
                t[0] = ""

# NUMBERS

    def p_list_of_primaries(t):
        'list_of_primaries : primary more_primaries'
        if type(t[1]) is not list:
            t[0] = [t[1]]
        else:
            t[0] = t[1]
        if t[2] != None: t[0].extend(t[2])

    def p_more_primaries(t):
        'more_primaries : COMMA primary more_primaries'
        if type(t[2]) is not list:
            t[0] = [t[2]]
        else:
            t[0] = t[2]
        if t[3] != None: t[0].extend(t[3])

    def p_more_primaries_e(t):
        'more_primaries :'
        pass

    def p_primary_num(t):
        'primary : number'
        t[0] = t[1]

    def p_primary(t):
        'primary : identifier range'
        if t[2].type is 'Range':
            t[0] = t[2].wire_enumeration(t[1])
        else:
            t[0] = t[1] + str(t[2])

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

# IDENTIFIERS

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

# OTHER FUNCTIONS

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

    # def explode_range(r):
    #     [a, b] = r.strip('[]').split(':')
        # for

    return yacc.yacc(tabmodule='ply_verilog_netlist_parsetab')
