for b in *.bed
do
	bn=`basename ${b}`
	rn=`echo ${bn} | sed s/.bed//g ` 
	awk '($5 >= 1)' ${b} > ${b}.filtered.bed
	#awk '($5 >= 4)' ${b} > ${b}.filtered.bed  ##for super bid bed
done

