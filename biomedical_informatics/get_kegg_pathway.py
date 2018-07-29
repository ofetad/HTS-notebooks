"""
keggPathway.py

python keggPathway.py -o sce
"""

import subprocess
import argparse
import sys
import re

def setArgs():
    """ adding arguments in the command line """
    parser = argparse.ArgumentParser()
    
    parser.add_argument(
        "-o",
        "--org",
        help = "KEGG organism")
    
    return parser.parse_args()

def query(org):
    """ query pathway list and pathway genes from KEGG

    Args:
        org     (String): short name of your organism (ex: Homo sapien -> hsa)

    Returns:
        None
    
    Output:
        two files temptKEGGPathList.txt and temptKEGGPathGene.txt in the input data directory
    """
    # initialization
    keggPathList = "http://rest.kegg.jp/list/pathway/" + org
    keggPathGene = "http://rest.kegg.jp/link/" + org + "/pathway/"
    
    # Query KEGG Pathway List
    try:
        file = open('temptKEGGPathList.txt', 'w')
        output = subprocess.call(
                "curl -s " + keggPathList, 
                stdout = file,
                shell = True)
        file.close()
        #print("Query KEGG Pathway List  --- Succeed")
    except:
        print("ERROR in querying KEGG pathway list of organism: " + org)
        sys.exit()

    # Query KEGG Pathway Genes
    try:
        file = open('temptKEGGPathGene.txt', 'w')
        output = subprocess.call(
                "curl -s " + keggPathGene,
                stdout = file,
                shell = True)
        file.close()
        #print("Query KEGG Pathway Genes --- Succeed")
    except:
        print("ERROR in querying KEGG gene list for each pathway of organism: " + org)
        sys.exit()

def organize_pathways(file_path_list = "temptKEGGPathList.txt", 
                      file_path_gene = "temptKEGGPathGene.txt"):
    """ Arrange the temptKEGGPathList.txt and temptKEGGPathGene.txt into a gmt file format
        (https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats)
        
    Args:
        filename (String): the filename your want to store pathway file
        datadir  (String): your path directory of the data

    Returns:
        None
    """
    # Initialization
    pathGene = dict()
    
    # Open the file
    filePathList = open(file_path_list, 'r')
    filePathGene = open(file_path_gene, 'r')
    
    # pathway List
    pat = re.compile(r':|\t| - ')
    for line in filePathList:
        # preprocess the info of pathway list
        tempt = re.split(pat, line.strip())
        # for example:
        # ['path', 'hsa00010', 'Glycolysis / Gluconeogenesis', 'Homo sapiens (human)']
        # -> tempt 1: KEGG pathway id
        # -> tempt 2: KEGG pathway description
        pathGene[tempt[1]] = tempt[2]
    
    # pathway-gene list
    pat = re.compile(r':|\t')
    for line in filePathGene:
        # preprocess the info of pathway-gene list
        tempt = re.split(pat, line.strip())
        # for example:
        # ['path', 'hsa00010', 'hsa', '10327']
        # 1: KEGG pathway id
        # 2: Gene id (ensembl, ncbi, ......)
        gene = tempt[3].upper() # make sure it is uppercase
        pathGene[tempt[1]] = pathGene[tempt[1]] + "\t" + gene
    
    # close the file
    filePathList.close()
    filePathGene.close()
    
    # store the pathway alphabetically
    return pathGene
        
        

if __name__ == '__main__':
    # parsing arguments
    args = setArgs()

    # set file paths and names
    query(args.org)
    pathGene = organize_pathways()
    
    # print out the gene list
    for key in sorted(pathGene):
        print(key + "\t" + pathGene[key])