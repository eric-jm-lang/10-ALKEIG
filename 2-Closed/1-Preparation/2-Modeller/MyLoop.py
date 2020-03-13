from modeller import *
from modeller.automodel import *

class MyLoop(automodel):
        def special_patches(self, aln):
            self.rename_segments(segment_ids=['A', 'B', 'C', 'D', 'E', 'F',], renumber_residues=[2, 2, 2, 1, 2, 1])

        def select_atoms(self):
            return selection(self.residue_range('2:A', '2:A'), self.residue_range('31:E', '31:E'), self.residue_range('31:F', '31:F'))
            
        #def special_restraints(self, aln):
            #rsr = self.restraints
            #rsr.add(secondary_structure.alpha(self.residue_range('2:A', '31:A')))
            #rsr.add(secondary_structure.alpha(self.residue_range('2:E', '31:E')))
            #rsr.add(secondary_structure.alpha(self.residue_range('2:F', '31:F')))
