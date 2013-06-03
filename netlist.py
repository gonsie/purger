class Range:
	def __init__(self, start=None, end=None):
		if end is not None:
			self.type = 'Range'
			self.start = min(start, end)
			self.end = max(start, end)
		elif start is not None:
			self.type = 'Single'
			self.value = start
		else:
			self.type = 'None'

	def __repr__(self):
		if self.type is 'None':
			return ""
		elif self.type is 'Single':
			return "[" + str(self.value) + "]"
		elif self.type is 'Range':
			return "[" + str(self.start) + ":" + str(self.end) + "]"

	def enumeration(self):
		if self.type is 'Range':
			return range(self.start, self.end + 1)
		elif self.type is 'Single':
			return [self.value]
		else:
			return []

	def parse_string(self, s):
		if s == None or s == "":
			self.type = 'None'
		elif ':' in s:
			self.type = 'Range'
			r = s.strip('[]').split(':')
			self.start = r[0]
			self.end = r[1]
		else:
			self.type = 'Single'
			self.value = s.strip('[]')
