


for f in ../hic/*.bedpe.gz
do
    bn=`basename $f`
    rn=`echo $bn | sed s/.bedpe.gz//g`
    
    for p in ./peak/*.bed
    do
        pn=`basename $p`
        if ! [ -f $pn.$rn.bed ]
        then
	        echo $pn.$rn.bed
    	    qsub -N gl.$rn.$pn -v inreadsbedpe=$f,inpeaksbed=$p,outtsv=$pn.$rn.bed ../getloops.pbs
	        sleep 0.1
        fi
    done
done


