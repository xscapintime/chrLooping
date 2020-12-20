for f in *_r*.bed
do
   echo "#"`basename $f` > ${f}.intral_num.txt
   echo "#number of intra-chromosomal loops, threshold 1 read to 20-21 reads" >> ${f}.intral_num.txt
   zcat $f | awk '$7==1 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==2 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==3 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==4 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==5 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==6 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==7 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==8 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==9 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==10 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==11 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==12 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==13 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==14 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==15 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==16 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==17 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==18 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7==19 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
   zcat $f | awk '$7>=20 && $7<=21 && $1==$4 {print $0}'| wc -l >> ${f}.intral_num.txt
  
done

