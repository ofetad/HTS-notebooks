
library(tidyverse)

df <- read_tsv('data/gene_counts.txt')

df[1:10, 1:10]

options(repr.plot.width=4, repr.plot.height=3)

ggplot(df, aes(x=gene100, y=gene1001, color=method)) + 
geom_point()
ggsave('figs/fig1.png')

ggplot(df, aes(x=method, y=gene100)) +
geom_boxplot()
ggsave('figs/fig2.png')

ggplot(df, aes(x=Media, y=gene100, color=method)) +
geom_jitter(width=0.2)
ggsave('figs/fig3.png')

ggplot(df, aes(x=gene100)) +
facet_grid(person ~ method) +
geom_histogram(binwidth=50) 
ggsave('figs/fig4.png')

genes.top5 <- df %>% 
select(starts_with('gene')) %>% 
summarize_all(mean) %>% 
gather() %>% 
arrange(desc(value)) %>%
head(5)

genes.top5

genes.top5$key

df %>% 
select(c('method', genes.top5$key)) %>%
gather(gene, count, -method) %>%
mutate(logcount = log(count)) %>%
ggplot(aes(x=gene, y=logcount)) +
geom_boxplot() + 
facet_wrap(~ method) +
theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave('figs/fig5.png')
