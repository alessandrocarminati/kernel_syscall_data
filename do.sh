#!/bin/bash

process_item() {
	IFS=$'\n';
	gnuplotfn=tmp/$(uuidgen).$RANDOM.gnuplot
	csvfn=tmp/$(uuidgen).$RANDOM.csv
	for i in $(../main subgraph -file=source/${1}.dot -node=${1} | grep "\->" -v | cut -d"\"" -f2 | egrep -v "{|}"); do
		echo -n "$i,";
		../main subgraph -file=source/${1}.dot -node="${i}" |grep "\->"| wc -l;
		done | tee  stats/${1}.stats
	echo -ne "set datafile separator \",\"\nset terminal png size 10240,8192 noenhanced\nset output 'pngs/${1}.png'\n"\
	        "set style data histograms\nset style fill solid border -1\nset boxwidth 0.9\nset xlabel \"Labels\"\nset ylabel \"Frequency\"\nset title \"Bar Diagram with Vertical Labels\"\n"\
	        "set xtics rotate by 90 right\nplot '${csvfn}' using 2:xtic(1) title 'Frequency'">${gnuplotfn}
	cat stats/${1}.stats | sort -t, -k2,2n > ${csvfn}
	gnuplot ${gnuplotfn}
	rm source/${1}.dot
}


export -f process_item
ls source/*.dot | cut -d. -f1 | xargs -n1 basename | parallel -j 4 process_item


