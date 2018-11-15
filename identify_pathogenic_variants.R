
# Load variant calls
variants = read.delim("../../data/23andme/genome_Robert_Lesurf_v3_Full_20171013173417.txt", comment.char="#")
variants = variants[which(substr(as.character(variants$rsid), 1, 2) == "rs"), ]

# Extract pathologic variants from clinvar
# Download clinvar variant_summary file from ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited/archive/
clinvar = read.delim("../../data/23andme/variant_summary.txt")
clinvar = clinvar[grep("Pathogenic", as.character(clinvar$ClinicalSignificance)), ]
clinvar = clinvar[which(clinvar$Type == "single nucleotide variant"), ]
clinvar = clinvar[which(clinvar$Assembly == "GRCh37"), ]

# Get the common variants, but only keep ones where I have an alternate allele
common_rsid = intersect(as.character(variants$rsid), paste0("rs", clinvar$RS...dbSNP.))
pvariants = matrix(nrow = 0, ncol = ncol(variants)+ncol(clinvar), dimnames=list(NULL, c(colnames(variants), colnames(clinvar))))
for(i in common_rsid) {
	ttam_index = which(variants$rsid == i)
	ttam_alleles = as.character(variants$genotype[ttam_index])
	if(nchar(ttam_alleles) > 1)
		ttam_alleles = c(substr(ttam_alleles, 1, 1), substr(ttam_alleles, 2, 2))
	clinvar_index = which(clinvar$RS...dbSNP. == substr(i, 3, nchar(i)))
	clinvar_index_specific = clinvar_index[which(as.character(clinvar$AlternateAllele[clinvar_index]) %in% ttam_alleles)]
	if(length(clinvar_index_specific) > 1)
		stop(paste("Dang Rob, you've got multiple different pathologic variants at", i))
	if(length(clinvar_index_specific) == 1)
		pvariants = rbind(pvariants, c(as.character(as.matrix(variants[ttam_index, ])), as.character(as.matrix(clinvar[clinvar_index_specific, ]))))
}

# Save results
write.table(pvariants, file="../../data/23andme/genome_Robert_Lesurf_v3_Full_20171013173417_pathogenic.txt", sep="\t", quote=F, row.names=F, col.names=T)
