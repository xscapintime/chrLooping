echo "#overlapped no. of lines against RAD21_45689" > all.overlapped_45689.txt

for f in ../peak/out_45689/*.out
do
	bn=`basename $f`
	rn=`echo $bn | sed s/_.*//g`
	#ln=`bedtools intersect -a ctcf/CTCF_8086_peaks.bed -b ${f} -f 0.60 -wa -wb | wc -l`
	#echo "# overlapped no. of lines against CTCF_35846" > all.overlapped.txt
	echo ${rn}"_against_RAD21: " `cat ${f} | wc -l` >> all.overlapped_45689.txt
	
done

