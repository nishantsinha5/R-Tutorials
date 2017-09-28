#-------------------------------------------------------------------------------------#
# A ggplot2 overview based on                                                         #
# http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/) #
#-------------------------------------------------------------------------------------#
# Cedric Scherer (scherer@izw-berlin.de), 13. January 2017                            #
#-------------------------------------------------------------------------------------#

#### Install Packages ####
#install.packages("ggplot2")
#install.packages("ggthemes")
#install.packages("extrafont")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("tidyverse")
#install.packages("ggrepel")
#install.packages("reshape2")
#install.packages("akima")
#install.packages("ggridges")
#install.packages("shiny")

#### Load ggplot2 ####
library(ggplot2)

#### The Dataset ####
chic <- readRDS("chicago-nmmaps.Rds")
str(chic)
head(chic, 10)

#### A Default ggplot ####
(g <- ggplot(chic, aes(date, temp)))

g + geom_point()

(g <- g + geom_point(color = "firebrick"))

#### Working with Axes ####
(g <- g + labs(x = "Date", y = expression(paste("Temperature (", degree ~ F, ")"))))

g + theme(axis.title.x = element_text(color = "sienna", size = 15, vjust = -0.35),
          axis.title.y = element_text(color = "orangered", size = 15, vjust = 0.35))

g + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank())

g + theme(axis.text.x = element_text(angle = 50, size = 16, vjust = 0.5))

g + ylim(c(0, 50))

chic %>% 
  filter(temp > 25, o3 > 20) %>% 
  ggplot(aes(temp, o3)) + 
    geom_point() + 
    labs(x = expression(paste("Temperature higher than 25 ", degree ~ F, "")), 
         y = "Ozone higher than 20 ppb") +
    expand_limits(x = 0, y = 0)

ggplot(chic_red, aes(temp, o3)) + 
  geom_point() + 
  labs(x = expression(paste("Temperature higher than 25 ", degree ~ F, "")), y = "Ozone higher than 20 ppb") +
  coord_cartesian(xlim = c(0, max(chic_red$temp)), ylim = c(0, max(chic_red$o3)))

ggplot(chic, aes(temp, temp + rnorm(nrow(chic), sd = 20))) +
   geom_point() +
   labs(x = "Temperature") +
   xlim(c(0, 150)) + ylim(c(0, 150)) +
   coord_equal()

ggplot(chic, aes(date, temp)) +
   geom_point(color = "firebrick") +
   labs(x = "Year", y = "Temperature") +
   scale_y_continuous(label = function(x) {return(paste(x, "Degrees Fahrenheit"))}) 

#### Working with Titles ####
(g <- g + ggtitle("Temperatures in Chicago"))

g + labs(title = "Temperatures in Chicago", 
         subtitle = "Seasonal pattern of daily temperatures from 1997 to 2001", 
         caption = "Data from NMMAPS")

g + theme(plot.title = element_text(size = 15, face = "bold", margin = margin(10, 0, 10, 0)))

g + theme(plot.title = element_text(size = 15, face = 4, hjust = 1))

library(extrafont)
font_import()
loadfonts(device = "win")
fonts()  ## fonttable()
g + theme(plot.title = element_text(size = 18, family = "Times New Roman"))

g + ggtitle("Temperatures in Chicago\nfrom 1997 to 2001") + 
         theme(plot.title = element_text(size = 15, face = "bold", vjust = 1, lineheight = 0.6))

#### Working with Legends ####
(g <- ggplot(chic, aes(date, temp, color = factor(season))) +
        geom_point() +
        labs(x = "Year", y = "Temperature"))

g + theme(legend.position = "none")

chic$season <- factor(chic$season, levels = c("Spring", "Summer", "Autumn", "Winter"))
(g <- ggplot(chic, aes(date, temp, color = factor(season))) +
        geom_point() +
        labs(x = "Year", y = "Temperature"))

g + theme(legend.title = element_blank())

g + theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold"))

g + theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete("Seasons\nindicated\nby colors:")

g + theme(legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
   scale_color_discrete("Seasons:", labels=c("Mar - May", "Jun - Aug", "Sep - Nov", "Dec - Feb"))

g + theme(legend.key = element_rect(fill = "darkgoldenrod1"),
         legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete("Seasons")

g + theme(legend.key = element_rect(fill = NA),
         legend.title = element_text(colour = "chocolate", size = 14, face = "bold")) +
    scale_color_discrete("Seasons:") +
    guides(color = guide_legend(override.aes = list(size = 6)))

g + geom_rug() +
    theme(legend.title = element_text(colour = "chocolate", size = 14, face = 2)) +
    scale_color_discrete("Seasons:")

g + geom_rug(show.legend = F) +
   theme(legend.title = element_text(colour = "chocolate", size = 14, face = 2)) +
   scale_color_discrete("Seasons:")

ggplot(chic, aes(x = date, y = o3)) +
   geom_line(color = "grey") +
   geom_point(color = "red") + 
   labs(x = "Year", y = "Ozone")

ggplot(chic, aes(x = date, y = o3)) +
   geom_line(aes(color = "line")) +
   geom_point(aes(color = "points")) + 
   labs(x = "Year", y = "Ozone") +
   scale_color_discrete("Type:")

ggplot(chic, aes(x = date, y = o3)) +
   geom_line(aes(color = "line")) +
   geom_point(aes(color = "points")) +
   labs(x = "Year", y = "Ozone") +
   scale_color_manual("", values = c("points" = "red", "line" = "grey"))

ggplot(chic, aes(x = date, y = o3)) + 
   geom_line(aes(color = "line")) +  
   geom_point(aes(color = "points")) +
   labs(x = "Year", y = "Ozone") +
   scale_color_manual("", values = c("points" = "red", "line" = "grey"), guide = "legend") +
   guides(colour = guide_legend(override.aes = list(linetype = c(1, 0), shape = c(NA, 16))))

#### Working with Backgrounds ####
(g <- ggplot(chic, aes(date, temp)) +
         geom_point(color = "firebrick") +
         labs(x = "Year", y = "Temperature") +
         theme(panel.background = element_rect(fill = "white")))

(g <- g + theme(panel.grid.major = element_line(colour = "grey20", size = 0.5),
                panel.grid.minor = element_line(colour = "grey80", size = 0.25)))

g + scale_y_continuous(breaks = seq(0, 100, 10), minor_breaks = seq(0, 100, 2.5))

g + theme(plot.background = element_rect(fill = "grey60"))

#### Working with Margins ####
g + theme(plot.background = element_rect(fill = "grey60"),
          plot.margin = unit(c(1, 5, 1, 5), "cm"))  ## top, right, bottom, left

#### Working with Multi-Panel Plots ####
g <- ggplot(chic, aes(date, temp)) +
   geom_point(color = "chartreuse4") +
   labs(x = "Year", y = "Temperature")
g + facet_wrap(~year, nrow = 1)

g + facet_wrap(~year, nrow = 2)

g + facet_wrap(~year, nrow = 2, scales = "free")

ggplot(chic, aes(date, temp)) +
   geom_point(color = "orangered") +
   labs(x = "Year", y = "Temperature") +
   facet_grid(year~season)

p1 <- ggplot(chic, aes(date, temp, color = factor(season))) + 
         geom_point() + 
         labs(x = "Year", y = "Temperature") + 
         guides(colour=F) 
p2 <- ggplot(chic, aes(x = date, y = o3)) + 
         geom_line(color = "grey") + 
         geom_point(color = "red") + 
         labs(x = "Year", y = "Ozone")
library(grid)
pushViewport(viewport(layout = grid.layout(1, 2)))
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))

p1 <- ggplot(chic, aes(date, temp, color = factor(season))) + 
         geom_point() + labs(x = "Year", y = "Temperature") + theme(legend.title = element_blank())
p2 <- ggplot(chic, aes(x = date, y = o3)) + 
         geom_line(aes(color = "line")) + geom_point(aes(color = "points")) + labs(x = "Year", y = "Ozone") +
         scale_color_manual("", values = c("points" = "red", "line" = "grey"), guide = "legend") +
         guides(colour = guide_legend(override.aes = list(linetype = c(1, 0), shape = c(NA, 16))))
library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

#### Working with Themes ####
library(ggthemes)
ggplot(chic, aes(date, temp, color = factor(season))) +
   geom_point() +
   labs(x = "Year", y = "Temperature") + 
   ggtitle("Ups and Downs of Chicagos Daily Temperatures") +
   theme_economist() + 
   scale_colour_economist(name = "Seasons:") +
   theme(legend.title = element_text(size = 12, face = "bold"))

set.seed(2017)
chic.red <- chic[sample(nrow(chic), 50), ]
(t <- ggplot(chic.red, aes(temp, o3)) +
      geom_point() +
      labs(x = "Temperature", y = "Ozone") + 
      ggtitle("Temperature and Ozone Levels in Chicago") +
      theme_tufte() +
      stat_smooth(method = "lm", col = "black", size = 0.7, fill = "gray60", alpha = 0.2))

t + geom_rangeframe()
  
theme_set(theme_gray(base_size = 30))
ggplot(chic, aes(date, temp, color = factor(season))) + 
   geom_point() + 
   labs(x = "Year", y = "Temperature") + 
   guides(colour = F) 

theme_gray

theme_gray.mod <- function (base_size = 12, base_family = "") {
  half_line <- base_size/2
  theme(line = element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt"), 
        rect = element_rect(fill = "white", colour = "black", size = 0.5, linetype = 1), 
        text = element_text(family = base_family, face = "plain", colour = "black", size = base_size, lineheight = 0.9, 
                            hjust = 0.5, vjust = 0.5, angle = 0, margin = margin(), debug = F), 
        axis.line = element_blank(), 
        axis.line.x = NULL, 
        axis.line.y = NULL, 
        axis.text = element_text(size = base_size * 1.1, colour = "black"), 
        axis.text.x = element_text(margin = margin(t = 0.8 * half_line/2), vjust = 1), 
        axis.text.x.top = element_text(margin = margin(b = 0.8 * half_line/2), vjust = 0), 
        axis.text.y = element_text(margin = margin(r = 0.8 * half_line/2), hjust = 1), 
        axis.text.y.right = element_text(margin = margin(l = 0.8 * half_line/2), hjust = 0), 
        axis.ticks = element_line(colour = "black", size = 1), 
        axis.ticks.length = unit(half_line, "pt"), 
        axis.title.x = element_text(margin = margin(t = half_line), vjust = 1, size = base_size * 1.3, face = "bold"), 
        axis.title.x.top = element_text(margin = margin(b = half_line), vjust = 0), 
        axis.title.y = element_text(angle = 90, margin = margin(r = half_line), vjust = 1, size = base_size * 1.3, face = "bold"), 
        axis.title.y.right = element_text(angle = -90, margin = margin(l = half_line), vjust = 0), 
        legend.background = element_rect(colour = NA), 
        legend.spacing = unit(0.4, "cm"), 
        legend.spacing.x = NULL, 
        legend.spacing.y = NULL, 
        legend.margin = margin(0.2, 0.2, 0.2, 0.2, "cm"), 
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
        legend.box.margin = margin(0, 0, 0, 0, "cm"), 
        legend.box.background = element_blank(), 
        legend.box.spacing = unit(0.4, "cm"), 
        panel.background = element_rect(fill = "white", colour = NA),
        panel.border = element_rect(colour = "black", fill = NA, size = 2),
        panel.grid.major = element_line(colour = "grey80", size = 1.2),
        panel.grid.minor = element_line(colour = "grey80", size = 0.1),
        panel.spacing = unit(base_size, "pt"), 
        panel.spacing.x = NULL, 
        panel.spacing.y = NULL, 
        panel.ontop = F, 
        strip.background = element_rect(fill = "white", colour = "black"), 
        strip.text = element_text(colour = "black", size = base_size), 
        strip.text.x = element_text(margin = margin(t = half_line, b = half_line)), 
        strip.text.y = element_text(angle = -90, margin = margin(l = half_line, r = half_line)), 
        strip.placement = "inside", 
        strip.placement.x = NULL, 
        strip.placement.y = NULL, 
        strip.switch.pad.grid = unit(0.1, "cm"), 
        strip.switch.pad.wrap = unit(0.1, "cm"), 
        plot.background = element_rect(colour = NA), 
        plot.title = element_text(size = base_size * 1.8, hjust = 0.5, vjust = 1, face = "bold", margin = margin(b = half_line * 1.2)), 
        plot.subtitle = element_text(size = base_size * 1.3, hjust = 0.5, vjust = 1, margin = margin(b = half_line * 0.9)), 
        plot.caption = element_text(size = rel(0.9), hjust = 1, vjust = 1, margin = margin(t = half_line * 0.9)), 
        plot.margin = margin(base_size, base_size, base_size, base_size), complete = T)
}

theme_set(theme_gray.mod())

ggplot(chic, aes(date, temp, color = factor(season))) + 
   geom_point() + labs(x = "Year", y = "Temperature") + guides(colour = F)

theme_gray.mod <- theme_update(panel.background = element_rect(fill = "gray50"))
ggplot(chic, aes(date, temp, color = factor(season))) + 
   geom_point() + labs(x = "Year", y = "Temperature") + guides(colour = F)

theme_set(theme_gray())

#### Working with Colors ####
## categorial variables
(g <- ggplot(chic, aes(date, temp, color = factor(season))) +
         geom_point() + 
         labs(x = "Year", y = "Temperature") +
         theme(legend.title = element_blank()) +
         scale_color_manual(values = c("dodgerblue4", "darkolivegreen4", "darkorchid3", "goldenrod1")))

g + scale_color_brewer(palette = "Set1")

library(ggthemes)
g + scale_color_tableau()

## continiuous variables
(g <- ggplot(chic, aes(date, temp, color = o3)) + 
         geom_point() + 
         labs(x = "Year", y = "Temperature") + 
         scale_color_continuous("Ozone:"))

ggplot(chic, aes(date, temp, color = o3)) +  
   geom_point() + labs(x = "Year", y = "Ozone") +
   scale_color_gradient()

g + scale_color_gradient(low = "darkkhaki", high = "darkgreen", "Ozone:")

mid <- max(chic$o3) / 2  ## or mid <- mean(chic$o3)
g + theme(panel.background = element_rect(fill = "grey60")) + 
   scale_color_gradient2(midpoint = mid, low = "blue4", mid = "white", high = "red4", "Ozone:")

library(viridis)
p1 <- g + scale_color_viridis("Ozone:") + ggtitle("Viridis 'default'")
p2 <- g + scale_color_viridis(option = "inferno", "Ozone:") + ggtitle("Viridis 'inferno'")
library(gridExtra)
grid.arrange(p1, p2, ncol = 2)

ggplot(chic, aes(date, temp, color = factor(season))) +
   geom_point() + 
   labs(x = "Year", y = "Temperature") +
   theme(legend.title = element_blank(), 
         panel.background = element_rect(fill = "grey70"), 
         legend.key = element_rect(fill = "grey70")) +
   scale_color_viridis(discrete = T)

#### Working with Lines ####
g + geom_hline(yintercept = c(20, 73))

ggplot(chic, aes(temp, o3)) +
   geom_point() +
   labs(x = "Temperature", y = "Ozone") + 
   geom_vline(xintercept = quantile(chic$temp)[4], linetype = 2, color = "firebrick", size = 1.5) +
   geom_hline(yintercept = quantile(chic$o3)[4], linetype = 2, color = "firebrick", size = 1.5)

reg <- lm(o3 ~ temp, data = chic)
ggplot(chic, aes(temp, o3)) +
   geom_point() +
   labs(caption = paste0("y = ", round(coefficients(reg)[2], 2), " * x + ", round(coefficients(reg)[1], 2)), 
        x = "Temperature", y = "Ozone") + 
   geom_abline(intercept = coefficients(reg)[1], slope = coefficients(reg)[2], color = "darkorange1", size = 1.5)

#### Working with Text ####
set.seed(2017)
library(tidyverse)
sample <- chic %>% group_by(season) %>% sample_frac(0.01)
# base R code: sample <- sample_frac(group_by(chic, season), 0.01)

ggplot(sample, aes(date, temp, label = season)) +
   geom_point() + 
   geom_text(aes(colour = factor(temp)), hjust = 0.5, vjust = -0.5) +
   labs(x = "Year", y = "Temperature") +
   xlim(as.Date(c('1997-01-01', '2000-12-31'))) + ylim(c(0, 90)) +
   theme(legend.position = "none")

ggplot(sample, aes(date, temp, label = season)) +
   geom_point() + 
   geom_label(aes(fill = factor(temp)), colour = "white", fontface = "bold", hjust = 0.5, vjust = -0.25) +
   labs(x = "Year", y = "Temperature") +
   xlim(as.Date(c('1997-01-01', '2000-12-31'))) + ylim(c(0, 90)) +
   theme(legend.position = "none")

library(ggrepel)
ggplot(sample, aes(date, temp, label = season)) +
   geom_point() + 
   geom_text_repel(aes(colour = factor(temp)), size = 2.5) +
   labs(x = "Year", y = "Temperature") +
   xlim(as.Date(c('1997-01-01', '2000-12-31'))) + ylim(c(0, 90)) +
   theme(legend.position = "none")

ggplot(chic, aes(date, temp, label = season)) +
   geom_point() +
   geom_point(data = sample, aes(color = factor(temp)), size = 2.5) +
   geom_label_repel(data = sample, aes(fill = factor(temp)), colour = "white", fontface = "bold") +
   labs(x = "Year", y = "Temperature") +
   theme(legend.position = "none")

library(grid)
my_grob = grobTree(textGrob("This text stays in place!", x = 0.1, y = 0.95, hjust = 0, 
                            gp = gpar(col = "blue", fontsize = 15, fontface = "italic")))
ggplot(chic, aes(temp, o3)) +
   geom_point(color = "firebrick") + labs(x = "Temperature", y ="Ozone") +
   annotation_custom(my_grob)

ggplot(chic, aes(temp, o3)) +
   geom_point(color = "firebrick") + labs(x = "Temperature", y ="Ozone") +
   facet_wrap(~season, scales = "free") +
   annotation_custom(my_grob)

#### Working with Coordinates ####
ggplot(chic, aes(x = season, y = o3)) +
   geom_boxplot(fill = "indianred") + 
   labs(x = "Season", y = "Ozone") +
   coord_flip()

g + scale_y_reverse()

g + scale_y_log10(lim = c(0.1, 100)) +
   labs(x = "log(Temperature)", y = "Year")

#### Working with Plot Types ####
g <- ggplot(chic, aes(x = season, y = o3)) + 
         labs(x = "Season", y = "Ozone")
g + geom_boxplot(fill = "indianred")

g + geom_point(color = "firebrick")

g + geom_jitter(alpha = 0.5, aes(color = season), position = position_jitter(width = .6)) +
    theme(legend.title = element_blank())

g + geom_violin(color = "sienna", fill = "red", alpha = 0.4)

g + geom_violin(color = "gray", alpha = 0.5) +
   geom_jitter(aes(color = season), position = position_jitter(width = 0.3), alpha = 0.3) +
   theme(legend.title = element_blank()) +
   coord_flip()

ggplot(chic, aes(date, temp, color = factor(season))) +
   geom_point() +
   geom_rug() +
   labs(x = "Year", y = "Temperature") +
   theme(legend.position = "none")

chic$o3run <- as.numeric(stats::filter(chic$o3, rep(1/30, 30), sides = 2))
ggplot(chic, aes(date, o3run)) +
   geom_line(color = "chocolate", lwd = 1) +
   labs(x = "Year", y = "Temperature")

corm <- round(cor(chic[ ,sort(c("death", "temp", "dewpoint", "pm10", "o3"))], method = "pearson", use = "pairwise.complete.obs"), 2)
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

library(akima)
fld <- with(chic, interp(x = temp, y = o3, z = dewpoint))
library(reshape2)
df <- melt(fld$z, na.rm = T)
names(df) <- c("x", "y", "Dewpoint")
df$Temperature <- fld$x[df$x]
df$Ozone <- fld$y[df$y]
g <- ggplot(data = df, aes(x = Temperature, y = Ozone, z = Dewpoint)) +
   theme(panel.background = element_rect(fill = "white"),
         panel.border = element_rect(colour = "black", fill = NA),
         legend.title = element_text(size = 15),
         axis.text = element_text(size = 12),
         axis.title.x = element_text(size = 15, vjust = -0.5),
         axis.title.y = element_text(size = 15, vjust = 0.2),
         legend.text = element_text(size = 12))
g + stat_contour(aes(colour = ..level.., fill = Dewpoint))

g + geom_tile(aes(fill = Dewpoint)) +
      scale_fill_viridis(option = "inferno")

g + geom_tile(aes(fill = Dewpoint)) + 
      stat_contour(colour = "white", size = 0.7, bins = 5) + 
      scale_fill_viridis()

library(ggridges)
ggplot(chic, aes(temp, year)) + 
  geom_density_ridges(fill = "grey90") +
  labs(x = "Temperature [F]", y = "Year")

ggplot(chic, aes(temp, year, fill = year)) + 
  geom_density_ridges(alpha = 0.8, color = "white", scale = 2.5, rel_min_height = 0.01) + 
  labs(x = "Temperature [F]", y = "Year") + 
  guides(fill = F) +
  theme_ridges()

ggplot(chic, aes(x = temp, y = season, fill = ..x..)) + 
  geom_density_ridges_gradient(scale = 0.9, gradient_lwd = 0.5, color = "black") + 
  theme_ridges(grid = F) +
  scale_fill_viridis(option = "plasma", name = "") + 
  labs(x = "Temperature [F]", y = "Season")

library(tidyverse)
chic %>% 
   filter(season %in% c("Summer", "Winter")) %>% ## only plot extreme season using dplyr
   ggplot(aes(y = year)) +
   geom_density_ridges(aes(x = temp, fill = paste(year, season)), alpha = 0.7,
                       rel_min_height = 0.01, color = "white", from = -5, to = 95) +
   scale_fill_cyclical(breaks = c("1997 Summer", "1997 Winter"),
                       labels = c(`1997 Summer` = "Summer", 
                                  `1997 Winter` = "Winter"),
                       values = c("tomato", "dodgerblue"),
                       name = "Season", guide = "legend") +
   theme_ridges() + 
   labs(x = "Temperature [F]", y = "Year")

ggplot(chic, aes(x = temp, y = year, height = ..density.., fill = year)) + 
  geom_density_ridges(stat = "binline", bins = 25, scale = 0.9, 
                      draw_baseline = F, show.legend = F) + 
  labs(x = "Temperature [F]", y = "Season")

#### Working with Ribbons ####
ggplot(chic, aes(date, o3run)) +
   geom_ribbon(aes(ymin = 0, ymax = o3run), fill = "orange", color = "orange", alpha = 0.4) +
   geom_line(color = "chocolate", lwd = 1) +
   labs(x = "Year", y = "Temperature")

chic$mino3 <- chic$o3run - sd(chic$o3run, na.rm = T)
chic$maxo3 <- chic$o3run + sd(chic$o3run, na.rm = T)
ggplot(chic, aes(date, o3run)) +
   geom_ribbon(aes(ymin = mino3, ymax = maxo3), fill = "lightskyblue", color = "lightskyblue") +
   geom_line(color = "royalblue4", lwd = .7) +
   labs(x = "Year", y = "Temperature")

#### Working with Smoothings ####
ggplot(chic, aes(date, temp)) + 
   geom_point(color="firebrick")+
   labs(x = "Year", y = "Temperature") +
   stat_smooth()

ggplot(chic, aes(date, temp)) + 
   geom_point(color="grey60")+
   labs(x = "Year", y = "Temperature") +
   stat_smooth(method = "gam", formula = y~s(x, k = 300), se = F, size = 1.3, aes(col = "300")) +
   stat_smooth(method = "gam", formula = y~s(x, k = 50), se = F, size = 1, aes(col = "50")) +
   stat_smooth(method = "gam", formula = y~s(x, k = 10), se = F, size = 0.8, aes(col = "10")) +
   scale_colour_manual(name = "k", values=c("darkorange1", "firebrick", "dodgerblue3"))

ggplot(chic, aes(temp, death)) +
   geom_point(color = "firebrick") +
   labs(x = "Temperature", y = "Deaths") +
   stat_smooth(method = "lm", col = "darkorange1", se = F, size = 1.3)

lmTemp <- lm(death~temp, data = chic)
ggplot(chic, aes(temp, death)) + 
   geom_point(col = "firebrick") +
   labs(x = "Temperature", y = "Deaths") +
   geom_abline(intercept = lmTemp$coef[1], slope = lmTemp$coef[2], col = "darkorange1", size = 1.3)

#### Working with Interactive Graphs ####
library(shiny)
runExample("01_hello")
# shiny homepage: http://shiny.rstudio.com/

# plot.ly homepage: https://plot.ly/feed

#### Tipps & Tricks
# shiny app for learning ggplot2: http://databall.co/shiny/shinyggplot/?utm_source=r-bloggers.com&utm_medium=referral&utm_campaign=blogpost&utm_content=pic

