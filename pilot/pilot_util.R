
dendplot <- function(mydend, columndata, labvar, colvar, pchvar) {
    # plot dendrogram
    #
    # Args:
    #   mydend (Dendrogram): your input DESeq object
    #   columndata (DataFrame): the second count data
    #   labvar (Character): variable that show in label
    #   colvar (Character): variable that define color
    #   pchvar (Character): variable that define shape of points
    #
    # Returns:
    #   (Dendrogram) final plot of dendrogram
    cols   <- factor(columndata[[colvar]][order.dendrogram(mydend)])
    collab <- brewer.pal(max(3, nlevels(cols)), "Set1")[cols]
    pchs   <- factor(columndata[[pchvar]][order.dendrogram(mydend)])
    pchlab <- seq_len(nlevels(pchs))[pchs]
    lablab <- columndata[[labvar]][order.dendrogram(mydend)]
    
    mydend %>% 
        set("labels_cex", 1) %>% 
        set("labels_col", collab) %>%
        set("leaves_pch", pchlab) %>%
        set("labels",     lablab)
}

myinteractplot <- function(mydds, geneid, my_xaxis) {
    # plot gene expression value in different media and strain
    #
    # Args:
    #   mydds (DESeqTransform object): your input DESeq object
    #   geneid (Charater): the second count data
    #   my_xaxis (Charater): the x axis (ex: "media" or "strain")
    #
    # Returns:
    #   (ggplot object) the final plot
    assay(mydds) %>%
        as_tibble(rownames = "gene") %>%
        filter(gene == geneid) %>%
        gather(Label, value, -gene) %>%
        select(-gene) -> 
        genedat
    
    colData(mydds) %>%
        as.data.frame %>%
        as_tibble %>%
        full_join(genedat, by="Label") -> genedat

    mygeom  <-  geom_point()
    mypal   <- scale_colour_manual(name = "",  values = brewer.pal(3, "Set1"))
    mytheme <- theme_bw()
    mytitle <- ggtitle(geneid)
    
    my_xaxis <- rlang::sym(my_xaxis)
    gp <- ggplot(genedat, aes(x = !!my_xaxis, y = value, color = Media)) + mygeom + mytheme + mypal + mytitle
    
    return(gp)   
}

genefromdds <- function(mydds, geneid, linkid) {
    #assay(mydds) %>%
    counts(mydds, normalize = TRUE) %>%
        as_tibble(rownames="gene") %>%
        filter(gene==geneid) %>%
        gather(!!linkid, value, -gene) %>%
        select(-gene) ->
        genedat

    colData(mydds) %>%
        as.data.frame %>%
        as_tibble %>%
        full_join(genedat, by=linkid) ->
        genedat

    return(genedat)
}


myDEplot <- function(mydds, geneid, myfactor, linkid, dots = FALSE, addcolor = FALSE, mycolor) {
    
    genedat <- genefromdds(mydds, geneid, linkid)


    #mygeom <-  geom_boxplot(notch = FALSE)
    mypal <- scale_colour_manual(values = brewer.pal(5, "Set1"))
    mytheme <- theme_bw()

    #myfactor<-  rlang::enquo(myfactor)
    myfactor <- rlang::sym(myfactor)
    genedat <- genedat %>%
        dplyr::mutate(boxfactor = as_factor(!!myfactor))
    
    p <- ggplot(genedat, aes(y=value, x = boxfactor)) +
        mytheme + mypal + labs(y = geneid, x = myfactor)
        #mygeom + mytheme + mypal + labs(y = geneid, x = myfactor)
    
    if(dots) {
         if(addcolor) {
            mycolor <- enquo(mycolor)
            p <- p + geom_jitter(aes(color = mycolor), width = 0.1)
         } else {
            p <- p + geom_jitter(width = 0.1)
         }
    } else {
        p <- p + geom_boxplot(notch = FALSE)
    }
    
    return(p)
}
