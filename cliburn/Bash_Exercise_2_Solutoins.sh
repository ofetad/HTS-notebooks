
cleanup () { 
    :
}

trap "cleanup" SIGPIPE

mkdir -p refs

cd refs

wget ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz

gunzip Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz

ls

GTF=$(ls)

echo $GTF

head -10 $GTF

grep '^#' $GTF

cat $GTF |
grep -v '^#' | 
cut -f 1,3-5  | 
head -6

cat $GTF | grep -v '^#' | cut -f3 | sort | uniq -c

cat $GTF | grep -v '^#' | cut -f1 | sort -n | uniq 

cat $GTF |             # read file to standard input
grep -v '^#' |         # exclude header lines
cut -f9 |              # extract column 9
cut -f1 -d';' |        # extract column 1 using semi-colon as delimiter
cut -f2 -d' ' |        # extract column 2 using space as delimiter
tr -d '"' |            # remove double quotes
sort |                 # sort in lexicographic order
uniq > geen_counts.txt # save unique entries to text file

head geen_counts.txt

grep -v '^#' $GTF | 
awk -F '\t' '{print NF}' | 
sort | 
uniq -c

grep -v '^#' $GTF |
awk -F '\t' '$1=="2" && $3=="gene"'  | 
wc -l
