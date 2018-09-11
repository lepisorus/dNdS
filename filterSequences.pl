## This script was written to filter out genes whose sequences contain more than 20% 'N's and whose length is less than 200 in any of the three species (balsamifera, deltoides, tremula)






#!/usr/bin/perl
# USAGE:
# unix command line:
use strict;
use warnings;
my $input_file;
my $output_file;
my $new_file;
my $delete_file = "deletedGenes.txt";
open OUT, '>', $delete_file or die "Cannot open '$delete_file' because: $!";

for $input_file (@ARGV) {
    $new_file = $input_file;
    $new_file =~ s/\.fas//;
    $output_file = $new_file."\_filtered\.fas";

    process_file($input_file, $output_file, $new_file);
}

sub process_file {
   ($input_file, $output_file, $new_file) = @_;
open IN, '<', $input_file or die "Cannot open '$input_file' because: $!";


# By default Perl pulls in chunks of text up to a newline (\n) character; newline is
# the default Input Record Separator. You can change the Input Record Separator by
# using the special variable "$/". When dealing with FASTA files I normally change the
# Input Record Separator to ">" which allows your script to take in a full, multiline
# FASTA record at once.

$/ = ">";

# At each input your script will now read text up to and including the first ">" it encounters.
# This means you have to deal with the first ">" at the begining of the file as a special case.

my $junk = <IN>; # Discard the ">" at the begining of the file

# Now read through your input file one sequence record at a time. Each input record will be a
# multiline FASTA entry.

my $length_1;
my $numN_1;
my $percent_N_1;
my $length_2;
my $numN_2;
my $percent_N_2;

my $length_3;
my $numN_3;
my $percent_N_3;

my $length_4;
my $numN_4;
my $percent_N_4;

my $length_5;
my $numN_5;
my $percent_N_5;

my $length_6;
my $numN_6;
my $percent_N_6;

my $length_7;
my $numN_7;
my $percent_N_7;

my $length_8;
my $numN_8;
my $percent_N_8;

my $length_9;
my $numN_9;
my $percent_N_9;

my $length_10;
my $numN_10;
my $percent_N_10;

my $length_11;
my $numN_11;
my $percent_N_11;

my $length_12;
my $numN_12;
my $percent_N_12;

my $length_13;
my $numN_13;
my $percent_N_13;

my $length_14;
my $numN_14;
my $percent_N_14;

my $length_15;
my $numN_15;
my $percent_N_15;


while ( my $record = <IN> ) {
	chomp $record; # Remove the ">" from the end of $record, and realize that the ">" is already gone from the begining of the record
	
# 	Now split up your record into its definition line and sequence lines using split at each newline.
# 	The definition will be stored in a scalar variable and each sequence line as an
# 	element of an array.
	
	my ($defLine, @seqLines) = split /\n/, $record;
	
#	Join the individual sequence lines into one single sequence and store in a scalar variable.
	
	my $sequence = join('',@seqLines); # Concatenates all elements of the @seqLines array into a single string.



if ($defLine =~ m/^B.breviceps/) {
         $length_1 = length($sequence);
         $numN_1 = ($sequence =~ tr/N/N/);
         $percent_N_1 = $numN_1/$length_1;  
}

elsif ($defLine =~ m/^B.confuses/) {
         $length_2 = length($sequence);
         $numN_2 = ($sequence =~ tr/N/N/);
         $percent_N_2 = $numN_2/$length_2;  
}

elsif ($defLine =~ m/^B.consobrinus/) {
         $length_3 = length($sequence);
         $numN_3 = ($sequence =~ tr/N/N/);
         $percent_N_3 = $numN_3/$length_3;  
}
elsif ($defLine =~ m/^B.cullumanus/) {
         $length_4 = length($sequence);
         $numN_4 = ($sequence =~ tr/N/N/);
         $percent_N_4 = $numN_4/$length_4;  
}
elsif ($defLine =~ m/^B.difficillimus/) {
         $length_5 = length($sequence);
         $numN_5 = ($sequence =~ tr/N/N/);
         $percent_N_5 = $numN_5/$length_5;  
}
elsif ($defLine =~ m/^B.haemorrhoidalis/) {
         $length_6 = length($sequence);
         $numN_6 = ($sequence =~ tr/N/N/);
         $percent_N_6 = $numN_6/$length_6;  
}
elsif ($defLine =~ m/^B.ignitus/) {
         $length_7 = length($sequence);
         $numN_7 = ($sequence =~ tr/N/N/);
         $percent_N_7 = $numN_7/$length_7;  
}
elsif ($defLine =~ m/^B.opulentus/) {
         $length_8 = length($sequence);
         $numN_8 = ($sequence =~ tr/N/N/);
         $percent_N_8 = $numN_8/$length_8;  
}
elsif ($defLine =~ m/^B.picipes/) {
         $length_9 = length($sequence);
         $numN_9 = ($sequence =~ tr/N/N/);
         $percent_N_9 = $numN_9/$length_9;  
}
elsif ($defLine =~ m/^B.polaris/) {
         $length_10 = length($sequence);
         $numN_10 = ($sequence =~ tr/N/N/);
         $percent_N_10 = $numN_10/$length_10;  
}
elsif ($defLine =~ m/^B.pyrosoma/) {
         $length_11 = length($sequence);
         $numN_11 = ($sequence =~ tr/N/N/);
         $percent_N_11 = $numN_11/$length_11;  
}
elsif ($defLine =~ m/^B.sibiricus/) {
         $length_12 = length($sequence);
         $numN_12 = ($sequence =~ tr/N/N/);
         $percent_N_12 = $numN_12/$length_12;  
}
elsif ($defLine =~ m/^B.soroeensis/) {
         $length_13 = length($sequence);
         $numN_13 = ($sequence =~ tr/N/N/);
         $percent_N_13 = $numN_13/$length_13;  
}
elsif ($defLine =~ m/^B.superbus/) {
         $length_14 = length($sequence);
         $numN_14 = ($sequence =~ tr/N/N/);
         $percent_N_14 = $numN_14/$length_14;  
}
elsif ($defLine =~ m/^B.turneri/) {
         $length_15 = length($sequence);
         $numN_15 = ($sequence =~ tr/N/N/);
         $percent_N_15 = $numN_15/$length_15;  
}

} #while

close IN;

if (($length_1 > 200) && ($percent_N_1 < 0.2) && ($length_2 > 200) && ($percent_N_2 < 0.2) && ($length_3 > 200) && ($percent_N_3 < 0.2) && ($length_4 > 200) && ($percent_N_4 < 0.2) && ($length_5 > 200) && ($percent_N_5 < 0.2) && ($length_6 > 200) && ($percent_N_6 < 0.2) && ($length_7 > 200) && ($percent_N_7 < 0.2) && ($length_8 > 200) && ($percent_N_8 < 0.2) && ($length_9 > 200) && ($percent_N_9 < 0.2) && ($length_10 > 200) && ($percent_N_10 < 0.2) && ($length_11 > 200) && ($percent_N_11 < 0.2) && ($length_12 > 200) && ($percent_N_12 < 0.2) && ($length_13 > 200) && ($percent_N_13 < 0.2) && ($length_14 > 200) && ($percent_N_14 < 0.2) && ($length_15 > 200) && ($percent_N_15 < 0.2)) { 
    my $program = system ("cp $input_file  $output_file");
   print $program;
} #if 
else {
print OUT "$new_file\n";
} #else

} #sub
 close OUT;

