#!/bin/bash
chmod +x ./scrape_news.sh

wget -q https://www.ynetnews.com/category/3082

grep -o 'https://www.ynetnews.com/article/[0-9A-Za-z]\{9\}[#"]' 3082 > all_links.txt
grep -o 'https://www.ynetnews.com/article/[0-9A-Za-z]\{9\}' all_links.txt | uniq > links.txt
cat links.txt | wc -l > results.csv

while read -r link; do
 	wget -q $link -O curr_link.txt
 	Netanyahu_num=`cat curr_link.txt | grep -o "Netanyahu" | wc -l`
	Gantz_num=`cat curr_link.txt | grep -o "Gantz" | wc -l`
	echo -n "$link, " >> results.csv
	if [[ $Netanyahu_num == 0 && $Gantz_num == 0 ]]; then
 		echo "-" >> results.csv
 	else
 		echo "Netanyahu, $Netanyahu_num, Gantz, $Gantz_num" >> results.csv
 	fi
done < links.txt