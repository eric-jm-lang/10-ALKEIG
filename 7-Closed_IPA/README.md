## Preparation

### Calculations for IPA/Water volume ratio of 25%

#### Numerical values

```
Water:
M = 18.015 g/mol
d = 0.9982 g/mL (20 C)
d = 0.99336 g/mL (37 C)

IPA:
M = 60.096 g/mol
d = 0.786 g/mL (20 C)

Na = 6.02214E23

T = 293.15
```

#### Volume of 1 molecule of IPA

```
m_wat = M_wat / Na
V_wat = m_wat / d_wat = M_wat / (Na*d_wat)
V_ipa = M_ipa / (Na * d_ipa)

V_ipa / V_wat = (M_ipa * d_wat) / (M_wat * d_ipa)
V_ipa / V_wat = 4.2365
```
So the volume of 1 molecule of IPA is equal to the volume of 4.2365 molecules of water.
So in a 50%/50% IPA/Water there is a 1/4.2365 ratio
And for a 25%/75% IPA/Water there is a 1/12.709 ratio


### Solvation of the closed form  with IPA + water

Start from `closed9.pdb` (closed structure after running solvate) 
`closed9.pdb` has 46 crystallographic waters and 3209 waters added by solvate,
so a total of 3255 water molecules.

to calculate tje number of water molecules x depending on the number of IPA molecules:
```
x = (y * 12.709) - 3255
``` 

### Preparation of the Amber input files 

#### Initial Solvation

Needs trial and error in order to adjust the number of waters to the desired value after fixing the number of IPA

With `tleap`:
```
source leaprc.protein.ff14SB   
source leaprc.water.tip3p   
source leaprc.gaff  
loadamberparams JorgAA_IPAnb.frcmod  
loadamberprep JorgAA_IPAnb.prepi  
IPA = loadpdb JorgAA_IPAbox.pdb  
set IPA restype solvent  
setbox IPA centers  
prot = loadpdb closed9.pdb   
charge prot   
solvateOct prot IPA 6 iso 0.5  
solvateOct prot TIP3PBOX 9.75 iso 0.5   
```  
This gives a total of 9307 waters added so a grand total of 12562 water molecules for 982 IPA molecules.

#### Calculate the number of ions to add

The charge of the protein is `+6`
The number of ions to add to reach a ionic concentration C of 0.1 M:
```
n_ions = (((M_wat * N_wat) / (d_wat * 1000)) + ((M_ipa * N_ipa) / (d_ipa * 1000))) * C
n_ions = (((18.015 * 12562) / (0.9982 * 1000)) + ((60.096 * 982) / (0.786 * 1000))) * 0.1
n_ions = 30.17
```
So a total of 30 Na+ and 36 Cl- need to be added.

#### Solvation + ionisation

With `tleap`:
```
source leaprc.protein.ff14SB
source leaprc.water.tip3p
source leaprc.gaff
loadamberparams JorgAA_IPAnb.frcmod
loadamberprep JorgAA_IPAnb.prepi
IPA = loadpdb JorgAA_IPAbox.pdb
set IPA restype solvent
setbox IPA centers
prot = loadpdb closed9.pdb
charge prot
solvateOct prot IPA 6 iso 0.5
solvateOct prot TIP3PBOX 9.75 iso 0.5
addIonsRand prot Cl- 36 Na+ 30
charge prot
saveAmberParm prot closed_ipa_10.parm7 closed_ipa_10.rst7
quit
```

#### Align the channel axis to the z-axis

```
cp closed_ipa_10.rst7 closed_ipa_10.rst7.ORG 
mv closed_ipa_10.rst7 TEMP_closed_ipa_10.rst7 
```

With `cpptraj`:
```
parm closed_ipa_10.parm7
trajin TEMP_closed_ipa_10.rst7
principal :1-192 dorotation mass
center mass origin :1-192
trajout closed_ipa_10.rst7
trajout closed_ipa_10.pdb
run
quit
```
#### Create the parameter file for Hydrogen mass repartition scheme

With `parmed`:
```
parm closed_ipa_10.parm7
HMassRepartition
outparm closed_ipa_10_HMR.parm7
quit

```

### Prepare the input and slurm files

```
cd Input_and_slurm_files
mkdir ../../2-MD1
```

Edit the `*.i` files if needed and the `prepare_slurm_scripts_1.sh`
run
```
bash prepare_slurm_scripts_1.sh
```
Then start the jobs

this leads a 1 us of dynamics, to expand it to 2 us, run `prepare_slurm_scripts_2.sh`
then start the jobs

## Analysis





