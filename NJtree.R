library(phangorn)
library(optparse)

option_list <- list(make_option(c('-i','--in_file'), action='store', type='character', default=NULL, help='input'),
		    make_option(c('-o','--out_file'), action='store', type='character', default=NULL, help='output')
		                        )
opt <- parse_args(OptionParser(option_list = option_list))


data <- read.dna(opt$in_file, format="fasta")
data <- phyDat(data)
data


#dm <- dist.dna(as.DNAbin(data), pairwise.deletion=TRUE)  
dm <- dist.ml(data)
treeNJ <- NJ(dm)


#pdf("cheng15SpeciesNJtree.pdf")
#root_name <- "B.superbus"
#plot(ladderize(root(treeNJ, match(root_name, treeNJ$tip.label))), type="phylogram", show.node.label=T, underscore=T, cex=0.8, no.margin=T)
#dev.off()
write.tree(treeNJ, file=opt$out_file)

#bs <- bootstrap.phyDat(data, FUN=function(x)NJ(dist.ml(x)), bs=100)
#pdf("PBEfinalSNP.NJtree_bs.pdf")
#treeBS <- plotBS(treeNJ, bs, type="phylogram", bs.col="red", bs.adj=NULL)
#treeBS
#dev.off()

#write.tree(treeBS, file="PBEfinalSNP.NJ_BS.tre")




