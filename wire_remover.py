# Elsa Gonsiorowski
# Rensselaer Polytechnic Institute
# May 7, 2013

import sqlite3

def main(dbname, wire_dic, gate_types, pin_dir):
	con = sqlite3.connect(dbname)
	cur = con.cursor()
	count = len(wire_dic)
	for w in wire_dic:
		if len(wire_dic[w]) != 2:
			# create a branching wire entry
			pass
		else:
			results = []
			for g in wire_dic[w]:
				cur.execute("SELECT * FROM " + gate_types[g] + " WHERE cell_name = \"" + g + "\";")
				res = cur.fetchone()
				c = [cn[0] for cn in cur.description]
				results.append([g, c[res.index(w)], res[0]])
			for i in range(2):
				cur.execute("UPDATE " + gate_types[results[i][0]] + " SET " + results[i][1] + " = " + str(results[i-1][2]) + " WHERE cell_name = \"" + results[i][0] + "\";")
			con.commit()
		count -= 1
		if (count % 1000) == 0:
			print count
	con.commit()
	con.close()
