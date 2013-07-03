#!/bin/bash

set -e # Die if an error occurs

LANG=C
export LANG

TMP=`pwd`/target
export TMP

( # Process each of the files (formerly make-hourly.sh, run by make-monthly.sh)
	for yearmonthday in $(
				# Get the bit after the first dash, which is the date
				ls -1 source/pagecounts-*.gz |
				 awk 'BEGIN { FS="-" } { print $2 }' |
				 uniq
			); do
		if [ -e target/$yearmonthday.out.gz ]; then # File already processed
			cat target/$yearmonthday.out.gz | gunzip
		else
			perl bin/phase1hz.pl source/pagecounts-$yearmonthday-* |
			 sort -T$TMP  -k 3 -t " " |
			 perl bin/tally.pl |
			 tee >(gzip > target/$yearmonthday.out.gz) # Cache file
		fi
	done
) |
# Do things to the aggregate (formerly make-merged.sh)
 sort -T$TMP -k 3 -t " " |
 ./bin/average-trim.pl |
# And save it!
 gzip > target/hitcounts.raw.gz
