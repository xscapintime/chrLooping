for f in *bed.out 
do
   tail $f -n 21 | awk '{print $3,$4}' > $f.histo.txt
done

