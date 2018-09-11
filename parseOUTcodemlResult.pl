#!/usr/bin/perl
# USAGE: perl 
# unix command line: perl parseOUTcodemlResult.pl *mlc
use strict;
use warnings;
my $input_file;
my $geneName; 

my $output_file = "results.txt"; #change the output file name here
open (OUT, ">", $output_file);
print OUT "geneName\tdN/dS\n";


for $input_file (@ARGV) {
    $geneName = $input_file;
    $geneName =~ s/\.4Paml\_filtered\.mlc//;#change the expression pattern here 

    process_file($input_file, $geneName);
}


sub process_file {
    my ($input_file, $geneName) = @_;
    open (IN, "<", $input_file) or die "Can't open '$input_file': $!";
while (my $line=<IN>) { 
       $line =~ s/^\s+//g; 
       if ($line=~m/^omega/) {  #change the expression here when the tree changes
         print OUT "$geneName\t$line"; } #if	 
	} #while
    
close IN;

} #sub
close OUT;

