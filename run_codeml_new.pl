#!/usr/local/bin/perl

die "usage: [directory] (treefile)\n" unless (scalar(@ARGV)>0);

my $exe="/opt/rit/spack-app/linux-rhel7-x86_64/gcc-4.8.5/paml-4.9e-hdo4agddkmqjfhqbh3sjjj4p2zwtuh6n/bin/codeml"; #change the directory on different server
my $ctlfile="codeml.ctl";
my $rundir=shift @ARGV;
my $file=shift @ARGV;
my $treefile=$file; #change the tree file name here
$treefile=~ s/4Paml\_filtered\.fas/new\.tree/g;

#my @nucfiles;
#open (LS, "ls $rundir |");
#while (my $line=<LS>) {
#	if ($line =~ m/(\S+.fas)/) {  #change the suffix of the sequence files. 
#		push @nucfiles, $1;
#	}
#}
#close LS;
#print scalar(@nucfiles), " files found\n";

my $nsp = 15; #change the species number if input file changed


my @controlfile;
open (CTL, "<", $ctlfile);
while (my $line=<CTL>) { push @controlfile, $line; }
close CTL;

die "$ctlfile not read\n" unless (@controlfile);

	my $n = 0;
	open (FILE, "<", "$rundir/$file");
	while (my $line=<FILE>) { 
		$n++ if ($line=~m/>/);	 #if the sequence file is not fasta format, there will be a problem related to reading the number of species in the sequence file.
	}
	close FILE;
	my $name;
	if ($file =~ m/(\S+)\.fas/) { $name=$1;}
	else { $name=$file; }
	
	if ($treefile ne "none") {	
		if ($n !=$nsp) { print "$file has only $n sequences\n";  }

	
	open (CTL, ">", "$rundir/codeml.ctl");
	for my $line (@controlfile) {
		if ($line=~m/seqfile/) { print CTL "     seqfile = $rundir/$file * sequence data filename\n"; }
		elsif ($line=~m/treefile/) { 
			if ($treefile ne "none") { print CTL "     treefile = $treefile      * tree structure file name\n"; }
			else { print CTL "    treefile = $rundir/$name.dnd      * tree structure file name\n"; }
		}
		elsif ($line=~m/outfile/) { print CTL "     outfile = $rundir/$name.mlc           * main result file name\n"; }
		else { print CTL $line; }
	}
	close CTL;
	open (PAML, "$exe $rundir/codeml.ctl |"); while (my $line=<PAML>) { print $line; } close PAML;
	print "\n";
}
	
