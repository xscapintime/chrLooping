dos2unix ./1028/newlist/nameidlist.txt

cut -d '_' -f 1 ./1028/newlist/nameidlist.txt > name
cut -d '_' -f 2 ./1028/newlist/nameidlist.txt > id
paste name id > name_id

cat name_id | while read i 
do
	name_id=($i)
	name=${name_id[0]}
	id=${name_id[1]}
	mv ${id}*_r1.bed.out.histo.txt ${name}_${id}_r1.bed.out.histo.txt
	mv ${id}*_r2.bed.out.histo.txt ${name}_${id}_r2.bed.out.histo.txt
done


	
