#!/usr/bin/perl

$_ = <STDIN>;
chomp;
($date, $tally, $oldpage) = split / /, $_, 3;

while ( <STDIN> ) {
$i++;
if (              0 == $i %  1000000)  { print STDERR "."; }
if ( ($i > 0) && (0 == $i % 80000000)) { print STDERR "\n"; }
 chomp;
 ($date, $count, $page) = split / /, $_, 3;
 if ( $page eq $oldpage ) { 
   $tally += $count;
 } else { 
   print "$date $tally $oldpage\n";
   $oldpage = $page;
   $tally = $count;
 }
}
   
print "$date $tally $oldpage\n";
print STDERR "\n";
