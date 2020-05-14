

for i in {1..5}; do
	for j in 14 46 78 110 142 174; do 
		grep "$j,A,CB" -i Cluster_${i}_IPA.pdb.cs
		grep "$j,A,HB" -i Cluster_${i}_IPA.pdb.cs
	done
done
