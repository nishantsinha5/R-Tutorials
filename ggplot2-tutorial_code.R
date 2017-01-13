#-------------------------------------------------------------------------------------#
# A ggplot2 tutorial based on                                                         #
# http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/) #
#-------------------------------------------------------------------------------------#
# Cédric Scherer (scherer@izw-berlin.de), 11. January 2017                            #
#-------------------------------------------------------------------------------------#

#### Install packages ####
#install.packages("ggplot2")
#install.packages("ggthemes")
#install.packages("extrafont")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("reshape2")
#install.packages("rgdal")
#install.packages("shiny")

#### Load ggplot2 ####
library(ggplot2)

#### The dataset ####
df.chic <- readRDS("chicago-nmmaps.Rds")
str(df.chic)
head(df.chic, 10)

#### A default ggplot ####
g <- ggplot(df.chic, aes(date, temp))
g <- g + geom_point()
g

g <- g + geom_point(color = "firebrick")
g

#### Working with axes ####
g <- g + labs(x = "Date", y = expression(paste("Temperature (", degree ~ F, ")")))
g

g + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank())

g + theme(axis.text.x = element_text(angle = 50, size = 16, vjust = 0.5))

g + theme(axis.title.x = element_text(color = "sienna", size = 15, vjust = -0.35),
          axis.title.y = element_text(color = "orangered", size = 15, vjust = 0.35))

g + ylim(c(0, 50))

ggplot(df.chic, aes(temp, temp + rnorm(nrow(df.chic), sd = 20))) +
   geom_point() +
   labs(x = "Temperature") +
   xlim(c(0, 150)) + ylim(c(0, 150)) +
   coord_equal()

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "firebrick") +
   labs(x = "Year", y = "Temperature") +
   scale_y_continuous(label = function(x) {return(paste(x, "Degrees Fahrenheit"))}) 

#### Working with titles ####
g <- g + ggtitle("Temperatures in Chicago") +  ## or g + labs("Temperatures in Chicago")
g

g + theme(plot.title = element_text(size = 20, face = "bold", margin = margin(10, 0, 10, 0)))

library(extrafont)
font_import()
loadfonts(device = "win")
fonts()  ## fonttable()
g + theme(plot.title = element_text(size = 20, family = "Merriweather"))

g + ggtitle("Temperatures in Chicago\nfrom 1997 to 2001") + 
   theme(plot.title = element_text(size = 20, face = "bold", vjust = 1, lineheight = 0.6))

#### Working with legends ####
g <- ggplot(df.chic, aes(date, temp, color = factor(season))) +
         geom_point() +
         labs(x = "Year", y = "Temperature")
g

g + theme(legend.title = element_blank())

g + theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold"))

g + theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete(name = "Seasons\nindicated\nby colors:")

g + theme(legend.key = element_rect(fill = "darkgoldenrod1"),
         legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete(name = "Seasons\nindicated\nby colors:")

g + theme(legend.key = element_rect(fill = NA),
         legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete(name = "Seasons\nindicated\nby colors:") +
    guides(color = guide_legend(override.aes = list(size = 6)))

g + geom_text(data = df.chic, aes(date, temp, label = round(temp)), size = 4) +
    theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete(name = "Seasons\nindicated\nby colors:")

g + geom_text(data = df.chic, aes(date, temp, label = round(temp), size = 4), show.legend = F) +
    theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete(name = "Seasons\nindicated\nby colors:")

ggplot(df.chic, aes(x = date, y = o3)) +
   geom_line(color = "grey") +
   geom_point(color = "red") + 
   labs(x = "Year", y = "Ozone")

ggplot(df.chic, aes(x = date, y = o3)) +
   geom_line(aes(color = "line")) +
   geom_point(aes(color = "points")) + 
   labs(x = "Year", y = "Ozone") +
   scale_color_discrete(name = "Type:")

ggplot(df.chic, aes(x = date, y = o3)) +
   geom_line(aes(color = "line")) +
   geom_point(aes(color = "points")) +
   labs(x = "Year", y = "Ozone") +
   scale_color_manual(name = "", values = c("points" = "red", "line" = "grey"))

ggplot(df.chic, aes(x = date, y = o3)) + 
   geom_line(aes(color = "line")) +  
   geom_point(aes(color = "points")) +
   labs(x = "Year", y = "Ozone") +
   scale_color_manual(name = "", values = c("points" = "red", "line" = "grey"), guide = "legend") +
   guides(colour = guide_legend(override.aes = list(linetype = c(1, 0), shape = c(NA, 16))))

#### Working with backgrounds ####
ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "firebrick") +
   labs(x = "Year", y = "Temperature") +
   theme(panel.background = element_rect(fill = "grey60"))

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "firebrick") +
   labs(x = "Year", y = "Temperature") +
   theme(panel.background = element_rect(fill = "grey60"),
         panel.grid.major = element_line(colour = "orange", size = 1.5),
         panel.grid.minor = element_line(colour = "indianred"))

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "firebrick") +
   labs(x = "Year", y = "Temperature") +
   theme(plot.background = element_rect(fill = "grey60"))

#### Working with margins ####
ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "chocolate") +
   labs(x = "Year", y = "Temperature") +
   theme(plot.background = element_rect(fill = "grey60"),
         plot.margin = unit(c(1, 5, 1, 5), "cm"))  ## top, right, bottom, left

#### Working with multi-panel plots ####
ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "chartreuse4") +
   labs(x = "Year", y = "Temperature") +
   facet_wrap(~year, nrow = 1)

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "chartreuse4") +
   labs(x = "Year", y = "Temperature") +
   facet_wrap(~year, nrow = 2)

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "chartreuse4") +
   labs(x = "Year", y = "Temperature") +
   facet_wrap(~year, nrow = 2, scales = "free")

ggplot(df.chic, aes(date, temp)) +
   geom_point(color = "orangered") +
   labs(x = "Year", y = "Temperature") +
   facet_grid(year~season)

p1 <- ggplot(df.chic, aes(date, temp, color = factor(season))) + 
         geom_point() + 
         labs(x = "Year", y = "Temperature") + 
         guides(colour=F) 
p2 <- ggplot(df.chic, aes(x = date, y = o3)) + 
         geom_line(color = "grey") + 
         geom_point(color = "red") + 
         labs(x = "Year", y = "Ozone")
library(grid)
pushViewport(viewport(layout = grid.layout(1, 2)))
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))

p1 <- ggplot(df.chic, aes(date, temp, color = factor(season))) + 
         geom_point() + labs(x = "Year", y = "Temperature") + theme(legend.title = element_blank())
p2 <- ggplot(df.chic, aes(x = date, y = o3)) + 
         geom_line(aes(color = "line")) + geom_point(aes(color = "points")) + labs(x = "Year", y = "Ozone") +
         scale_color_manual(name = "", values = c("points" = "red", "line" = "grey"), guide = "legend") +
         guides(colour = guide_legend(override.aes = list(linetype = c(1, 0), shape = c(NA, 16))))
library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

#### Working with themes ####
library(ggthemes)
ggplot(df.chic, aes(date, temp, color = factor(season))) +
   geom_point() +
   labs(x = "Year", y = "Temperature") + 
   ggtitle("Ups and Downs of Chicagos Daily Temperatures") +
   theme_economist() + 
   scale_colour_economist(name = "Seasons:") +
   theme(legend.title = element_text(size = 12, face = "bold"))

set.seed(2017)
df.chic.red <- df.chic[sample(nrow(df.chic), 50), ]
ggplot(df.chic.red, aes(temp, o3)) +
   geom_point() +
   labs(x = "Temperature", y = "Ozone") + 
   ggtitle("Temperature and Ozone Levels in Chicago") +
   theme_tufte() +
   stat_smooth(method = "lm", col = "black", size = 0.7, fill = "gray60", alpha = 0.2)
  
theme_set(theme_gray(base_size = 30))
ggplot(df.chic, aes(date, temp, color = factor(season))) + 
   geom_point() + 
   labs(x = "Year", y = "Temperature") + 
   guides(colour = F) 

theme_gray

theme_gray.mod <- function (base_size = 12, base_family = "") 
{
   half_line <- base_size/2
   theme(line = element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt"), 
         rect = element_rect(fill = "white", colour = "black", size = 0.5, linetype = 1), 
         text = element_text(family = base_family, face = "plain", colour = "black", size = base_size, 
                             lineheight = 0.9, hjust = 0.5, vjust = 0.5, angle = 0, margin = margin(), debug = FALSE), 
         axis.line = element_line(), 
         axis.line.x = element_blank(), 
         axis.line.y = element_blank(), axis.text = element_text(size = rel(0.8), colour = "grey30"), 
         
         ## modified aesthetics of axes texts, ticks and titles
         axis.text.x = element_text(margin = margin(t = 0.8 * half_line/2), vjust = 1, size = 12, face = "bold"),
         axis.text.y = element_text(margin = margin(r = 0.8 * half_line/2), hjust = 1, size = 12, face = "bold"),
         axis.ticks = element_line(colour = "darkorange", size = 1.2),
         axis.ticks.length = unit(half_line, "pt"),
         axis.title.x = element_text(margin = margin(t = 0.8 * half_line, b = 0.8 * half_line/2), size = 15),
         axis.title.y = element_text(angle = 90, margin = margin(r = 0.8 * half_line, l = 0.8 * half_line/2), size = 15),
         
         legend.background = element_rect(colour = NA), 
         legend.margin = unit(0.2, "cm"), 
         legend.key = element_rect(fill = "grey95", colour = "white"), 
         legend.key.size = unit(1.2, "lines"), 
         legend.key.height = NULL, 
         legend.key.width = NULL, 
         legend.text = element_text(size = rel(0.8)), 
         legend.text.align = NULL, 
         legend.title = element_text(hjust = 0), 
         legend.title.align = NULL, 
         legend.position = "right", 
         legend.direction = NULL, 
         legend.justification = "center", 
         legend.box = NULL, 
         
         ## modified aesthetics of the panel and grid
         panel.background = element_rect(fill = "white", colour = NA),
         panel.border = element_rect(colour = "black", fill = NA, size = 1.2),
         panel.grid.major = element_line(colour = "darkorange", size = 1.2),
         panel.grid.minor = element_line(colour = "darkorange", size = 0.1),
         
         panel.margin = unit(half_line, "pt"), 
         panel.margin.x = NULL, 
         panel.margin.y = NULL, 
         panel.ontop = FALSE, 
         strip.background = element_rect(fill = "grey85", colour = NA), 
         strip.text = element_text(colour = "grey10", size = rel(0.8)),
         strip.text.x = element_text(margin = margin(t = half_line, b = half_line)), 
         strip.text.y = element_text(angle = -90, 
                                     margin = margin(l = half_line, r = half_line)), 
         strip.switch.pad.grid = unit(0.1, "cm"), 
         strip.switch.pad.wrap = unit(0.1, "cm"), 
         plot.background = element_rect(colour = "white"), 
         plot.title = element_text(size = rel(1.2), margin = margin(b = half_line * 1.2)), 
         plot.margin = margin(half_line, half_line, half_line, half_line), 
         complete = TRUE)
}
theme_set(theme_gray.mod())

ggplot(df.chic, aes(date, temp, color = factor(season))) + 
   geom_point() + labs(x = "Year", y = "Temperature") + guides(colour = F)

theme_gray.mod <- theme_update(panel.background = element_rect(fill = "gray50"))
ggplot(df.chic, aes(date, temp, color = factor(season))) + 
   geom_point() + labs(x = "Year", y = "Temperature") + guides(colour = F)

theme_set(theme_gray())

#### Working with colors ####
## categorial variables
g <- ggplot(df.chic, aes(date, temp, color = factor(season))) +
         geom_point() + 
         labs(x = "Year", y = "Temperature") +
         theme(legend.title = element_blank()) +
         scale_color_manual(values = c("dodgerblue4", "darkolivegreen4", "darkorchid3", "goldenrod1"))
g

g + scale_color_brewer(palette = "Set1")

library(ggthemes)
g + scale_color_tableau()

## continiuous variables
g <- ggplot(df.chic, aes(date, temp, color = o3)) + 
         geom_point() + 
         labs(x = "Year", y = "Temperature") + 
         #theme(legend.title = element_text(size = 13, face = "bold"),  #######!!!!!!!!!
          #     legend.text = element_text(size = 10)) +
         scale_color_continuous(name = "Ozone:")
g

#ggplot(df.chic, aes(date, temp, color = o3)) +  
#   geom_point() + labs(x = "Year", y = "Ozone") +
#   scale_color_gradient()

g + scale_color_gradient(low = "darkkhaki", high = "darkgreen", name = "Ozone:")

mid <- mean(df.chic$o3)
g + scale_color_gradient2(midpoint = mid, low = "blue4", mid = "white", high = "red4", name = "Ozone:")

#### Working with annotations ####
library(grid)
my_grob = grobTree(textGrob("This text stays in place!", x = 0.1, y = 0.95, hjust = 0, 
                            gp = gpar(col = "blue", fontsize = 15, fontface = "italic")))
ggplot(df.chic, aes(temp, o3)) +
   geom_point(color = "firebrick") + labs(x = "Temperature", y ="Ozone") +
   annotation_custom(my_grob)

ggplot(df.chic, aes(temp, o3)) +
   geom_point(color = "firebrick") + labs(x = "Temperature", y ="Ozone") +
   facet_wrap(~season, scales = "free") +
   annotation_custom(my_grob)

#### Working with coordinates ####
ggplot(df.chic, aes(x = season, y = o3)) +
   geom_boxplot(fill = "indianred") + 
   labs(x = "Season", y = "Ozone") +
   coord_flip()

#### Working with plot types ####
g <- ggplot(df.chic, aes(x = season, y = o3)) + 
         labs(x = "Season", y = "Ozone")
g + geom_boxplot(fill = "indianred")

g + geom_point(color = "firebrick")

g + geom_jitter(alpha = 0.5, aes(color = season), position = position_jitter(width = .6)) +
    theme(legend.title = element_blank())

g + geom_violin(alpha = 0.5, color = "sienna", fill = "indianred")

g + geom_violin(alpha = 0.5, color = "gray") +
    geom_jitter(alpha = 0.3, aes(color = season), position = position_jitter(width = .3)) +
    theme(legend.title = element_blank()) +
    coord_flip()

df.chic$o3run <- as.numeric(filter(df.chic$o3, rep(1/30, 30), sides = 2))
ggplot(df.chic, aes(date, o3run)) +
   geom_line(color = "chocolate", lwd = 1) +
   labs(x = "Year", y = "Temperature")

ggplot(df.chic, aes(date, o3run)) +
   geom_ribbon(aes(ymin = 0, ymax = o3run), fill = "orange", color = "orange", alpha = 0.4) +
   geom_line(color = "chocolate", lwd = 1) +
   labs(x = "Year", y = "Temperature")

df.chic$mino3 <- df.chic$o3run - sd(df.chic$o3run, na.rm = T)
df.chic$maxo3 <- df.chic$o3run + sd(df.chic$o3run, na.rm = T)
ggplot(df.chic, aes(date, o3run)) +
   geom_ribbon(aes(ymin = mino3, ymax = maxo3), fill = "lightskyblue", color = "lightskyblue") +
   geom_line(color = "royalblue4", lwd = .7) +
   labs(x = "Year", y = "Temperature")

corm <- round(cor(df.chic[ ,sort(c("death", "temp", "dewpoint", "pm10", "o3"))], method = "pearson", use = "pairwise.complete.obs"), 2)
corm[lower.tri(corm)] <- NA
corm
library(reshape2)
corm <- melt(corm)
corm$Var1 <- as.character(corm$Var1)
corm$Var2 <- as.character(corm$Var2)
corm <- na.omit(corm)
head(corm)
ggplot(corm, aes(Var2, Var1)) +
   geom_tile(data = corm, aes(fill = value), color = "white") +
   labs(x = "Variable 2", y = "Variable 1") +
   scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), name = "Correlation\n(Pearson)") +
   theme(axis.text.x = element_text(angle = 45, size = 11, vjust = 1, hjust = 1)) +
   coord_equal()

#### Working with smoothings ####
ggplot(df.chic, aes(date, temp)) + 
   geom_point(color="firebrick")+
   labs(x = "Year", y = "Temperature") +
   stat_smooth()

ggplot(df.chic, aes(date, temp)) + 
   geom_point(color="grey60")+
   labs(x = "Year", y = "Temperature") +
   stat_smooth(method = "gam", formula = y~s(x, k = 300), col = "darkorange1", se = F, size = 1.5) +
   stat_smooth(method = "gam", formula = y~s(x, k = 50), col = "firebrick", se = F, size = 1.3) +
   stat_smooth(method = "gam", formula = y~s(x, k = 10), col = "dodgerblue3", se = F, size = 1.1)

ggplot(df.chic, aes(temp, death)) +
   geom_point(color = "firebrick") +
   labs(x = "Temperature", y = "Deaths") +
   stat_smooth(method = "lm", col = "darkorange1", se = F, size = 1.3)

lmTemp <- lm(death~temp, data = df.chic)
ggplot(df.chic, aes(temp, death)) + 
   geom_point(col = "firebrick") +
   labs(x = "Temperature", y = "Deaths") +
   geom_abline(intercept = lmTemp$coef[1], slope = lmTemp$coef[2], col = "darkorange1", size = 1.3)

#### Working with maps ####
library(rgdal)
counties <- readOGR("nybb.shp", layer = "nybb")
ggplot() +  geom_polygon(data=counties, aes(x=long, y=lat, group=group))

library(maptools)
readShapePoly(system.file("nybb.shp", package="maptools"))

#### Working with interactive graphs ####
library(shiny)
runExample("01_hello")
