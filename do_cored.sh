#|/bin/sh
for i in $(ls source); do echo "processing $i"; ../main kerncollapse -file=source/$i -newnode=____core____ >cored_graphs/$i; done
