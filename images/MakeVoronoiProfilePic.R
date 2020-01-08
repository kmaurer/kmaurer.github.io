#### Make a voronoi style profile picture for github
# Based on our package ggvoronoi
# inspired by amazing use of ggvoronoi at http://mfviz.com/r-image-art/

library(imager)  
library(tidyverse)
library(ggvoronoi) 

setwd("~/GitHub/kmaurer.github.io/images")
img <- load.image(file = "Jamaica.jpg")
plot(img)

# img_df <- as.data.frame(img) %>%
#   spread(key = "cc", value="value") %>%
#   mutate(color=rgb(`1`,`2`,`3`))
# 
# names(img_df)[3:5] <- c("R","G","B")
# head(img_df)
# 
# ggplot() +
#   geom_tile(aes(x=x,y=y,fill=color),
#             data=img_df)


img_df_sample <- as.data.frame(img) %>%
  spread(key = "cc", value="value") %>%
  mutate(color=rgb(`1`,`2`,`3`)) %>%
  sample_frac(.02)

head(img_df_sample)

# ggplot() +
#   geom_point(aes(x=-x,y=-y, color=color),
#             data=img_df_sample)+
#   scale_color_identity()

ggplot() +
  geom_voronoi(aes(x=-x,y=-y,fill=color),
             data=img_df_sample)+
  scale_fill_identity() +
  scale_x_continuous(limits = c(-600,0)) +
  scale_y_continuous(limits = c(-600,0)) +
  theme_void()

ggsave("VoronoiProfileSmall.png", width=1.2,height=1.2,units="in", dpi=600)
