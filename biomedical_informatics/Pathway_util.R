get_gset_name_from_id <- function(pathid, mygenesets){
    id <- grep(pathid, names(genesets_cne_h99), value = TRUE)
    return(id)
}

get_gset_lst_from_id <- function(pathid, mygenesets){
    id <- get_gset_name_from_id(pathid, mygenesets)
    return(mygenesets[[id]])
}

get_gset_idx_from_name <- function(pathname, mygenesets){
    pathname_all <- names(mygenesets)
    lst <- lapply(pathname, function(x){
        return( grep(pattern = x, pathname_all, ignore.case = TRUE) )
    })
    idx <- Reduce(f = intersect, x = lst)
    return(idx)
}
