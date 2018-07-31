
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
    #   my_xaxis (Charater): the x axis ("media" or "strain")
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
    
    if (my_xaxis == "strain"){
        gp <- ggplot(genedat, aes(x = Strain, y = value, color = Media)) + mygeom + mytheme + mypal + mytitle
    } else {
        gp <- ggplot(genedat, aes(x = Media, y = value, color = Strain)) + mygeom + mytheme + mypal + mytitle
    }
    return(gp)   
}

genefromdds <- function(mydds, geneid, linkid) {
    assay(mydds) %>%
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


    mygeom <-  geom_boxplot(notch = FALSE)
    mypal <- scale_colour_manual(values = brewer.pal(5, "Set1"))
    mytheme <- theme_bw()

    myfactor<-  rlang::enquo(myfactor)
    genedat <- genedat %>%
        dplyr::mutate(boxfactor = as_factor(!!myfactor))
    

    p <- ggplot(genedat, aes(y=value, x = boxfactor))+
        mygeom + mytheme + mypal + labs(y = geneid, x = myfactor)

    if(dots) {
        p <- p + geom_point()
    }

    if(addcolor) {
        mycolor <- enquo(mycolor)
        p <- p + geom_point(aes_(color = mycolor))
    }
    
    return(p)
}
