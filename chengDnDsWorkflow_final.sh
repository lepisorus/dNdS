

#clean up the entry name for each sequence file
##in the raw folder
for f in *
do sed -i 's/[0-9]*//g' $f
done

#
##remove duplicate sequences in each file
for f in *CDSalign.fasta
do awk '/^>/{f=!d[$1];d[$1]=1}f' $f > $(basename $f | sed 's/CDSalign/noDup.CDS/g')
done

mkdir -p 15entry

##only keep files with 15 sequence entries
completeEntry()
{
    if [ $(grep ">" $1 | wc -l) = 15 ]; then
    cp $1 ./15entry
    fi
}   # end of completeEntry
  
for f in *noDup.CDS.fasta; 
do completeEntry $f
done 


cd ./15entry
## in 15entry, move the corresponding protein aligned files into 15entry as well
for f in *noDup.CDS.fasta; do mv ../$(basename $f | sed 's/noDup\.CDS.\.fasta/align/g') ./; done

cd ..
## in raw folder, mv 15entry to an upper level folder
mv 15entry ../



##change file name in the 15entry folder
for f in *fasta
do mv $f $(basename $f | sed 's/fasta/fas/g')
done

##delete files whose size is less than 2k
find . -name "*.fas" -size -2k -delete

#trim protein sequences with trimal
for f in *.protein.fasta_align; do \ 
g=$(echo $f | sed 's/\.fasta\_align//g');\ 
/work/LAS/mhufford-lab/lwang/cheng/trimAl/source/trimal -in $f -out ./trimmed/$g.fasta -fasta -automated1;\ 
done

#trim cds sequences
for f in *.protein.fasta_CDSalign.fasta; do \ 
g=$(echo $f | sed 's/protein\.fasta\_CDSalign\.fasta/CDS/g');\ 
/work/LAS/mhufford-lab/lwang/cheng/trimAl/source/trimal -in $f -out ./trimmed/$g.fasta -fasta -automated1;\  
done

## utilizing pal2nal.pl with input of CDS and protein sequence to generate codon-based fasta for PAML
for f in *.protein.fasta; do \  
g=$(echo $f | sed 's/protein/CDS/g');\ 
o=$(echo $f | sed 's/protein/4Paml/g');\
perl ../pal2nal.pl $f $g -output fasta -nogap -nomismatch -codontable 1 > ../for_paml/$o;\  
done

#  filter out genes whose sequences contain more than 20% 'N's and whose length is less than 200bp in any of the 15 species
perl filterSequences.pl *fas
mv *filtered.fas ../for_paml2

#generate NJ tree for each MSA
for f in cluster.1*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree1.command
for f in cluster.2*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree2.command
for f in cluster.3*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree3.command
for f in cluster.4*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree4.command
for f in cluster.5*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree5.command
for f in cluster.6*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree6.command
for f in cluster.7*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree7.command
for f in cluster.8*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree8.command
for f in cluster.9*fas ; do echo "Rscript NJtree.R -i $f -o $(basename $f | sed 's/4Paml\_filtered\.fas/tree/g')"; done > tree9.command

parallel --jobs 16 < tree1.command
parallel --jobs 16 < tree2.command
parallel --jobs 16 < tree3.command
parallel --jobs 16 < tree4.command
parallel --jobs 16 < tree5.command
parallel --jobs 16 < tree6.command
parallel --jobs 16 < tree7.command
parallel --jobs 16 < tree8.command
parallel --jobs 16 < tree9.command

#edit the tree file to make it suitable as input for PAML
for f in *tree; do sed -e 's/\://g' -e 's/[0-9]\.//g' -e 's/[0-9]*//g' -e 's/e\-//g' $f > $(basename $f | sed 's/tree/new\.tree/g'); done


#run the PAML analysis 
parallel --jobs 16 < ./codeml.command

#parse out the result
perl parseOUTcodemlResult.pl *mlc
