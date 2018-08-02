get_geneset_name <- function(pathid, mygenesets = genesets_cne_h99){
    id <- grep("ec00010", names(genesets_cne_h99), value = TRUE)
    return(id)
}

get_geneset_lst <- function(pathid, mygenesets = genesets_cne_h99){
    id <- get_geneset_name(pathid, mygenesets = mygenesets)
    return(mygenesets[[id]])
}

get_geneset_id <- function(pathname, mygenesets){
    pathname_all <- names(mygenesets)
    lst <- lapply(pathname, function(x){
        return( grep(pattern = x, pathname_all, ignore.case = TRUE) )
    })
    idx <- Reduce(f = intersect, x = lst)
    return(idx)
}
