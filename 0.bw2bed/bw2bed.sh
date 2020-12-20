for w in *.bw
do
	bn=`basename ${w}`
	rn=`echo $bn | sed s/.bw//g`
	bigWigToWig ${w} ${rn}.wig
	wig2bed < ${rn}.wig > ${rn}.bed
done


