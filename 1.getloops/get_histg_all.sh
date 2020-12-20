for f in ./*peaks.bed.hesc_primed_r{1..2}.bed.out 
do
   tail $f -n 22 >> $f.histo.txt
done

