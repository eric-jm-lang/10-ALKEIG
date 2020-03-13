from modeller import *
from modeller.automodel import *

class MyLoop(automodel):
        def special_patches(self, aln):
            self.rename_segments(segment_ids=['A', 'B', 'C', 'D', 'E', 'F',], renumber_residues=[1, 1, 1, 1, 1, 1])

        def select_atoms(self):
            return selection(self.residue_range('31:E', '31:E'))
            
        def special_restraints(self, aln):
            rsr = self.restraints
            rsr.add(secondary_structure.alpha(self.residue_range('2:E', '31:E')))
