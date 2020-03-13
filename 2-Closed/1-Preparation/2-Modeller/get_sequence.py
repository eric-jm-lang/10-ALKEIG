from modeller import *
code = 'closed1_nowat' # only this needs to be adapted
e = environ()
e.io.hetatm = True
m = model(e, file=code)
aln = alignment(e)
aln.append_model(m, align_codes=code)
aln.write(file=code+'.seq')
