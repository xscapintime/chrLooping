echo "#all.cfx | all TFs peak number " > tf_peaks.txt
for r in ../peak/*.bed
do
	bn=`basename $r`
	rn=`echo ${bn} | sed s/_peaks.*//g`
	echo ${rn}" peak number:" `wc -l ${r}` >> tf_peaks.txt
done

