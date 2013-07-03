#!/bin/sh

echo "Not implemented yet: the data files aren't available in Tool Labs."
echo "See https://bugzilla.wikimedia.org/show_bug.cgi?id=48894"
exit 2

YEAR=$1
MONTH=$2
if [ "$YEAR" = '' ] || [ "$MONTH" = '' ]; then
	echo "Usage: $0 year month"
	exit 1
fi

DATA=/public/datasets/public/pagecounts-raw # TODO See echos above.

for file in `ls -1 $SOURCE`; do
	ln -s $SOURCE/$file source/$file
done
