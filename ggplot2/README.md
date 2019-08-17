# ggplot2 Tutorial

Author: Cédric Scherer (cedricphilippscherer@gmail.com)

**You can find the latest version on my [homepage](https://cedricscherer.netlify.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/).**

The initial version of this tutorial follows a blog entry called [**Beautiful plotting in R: A ggplot2 cheatsheet**](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/) by zev@zevross.com, posted on 4. August 2014, updated last in January 2016.

![./img/overview.png](https://github.com/Z3tt/R-Tutorials/blob/master/ggplot2/img/overview.png)

### Introductory Words

Begin of 2016, I had to prepare my PhD introductory talk and I started using `ggplot2` to visualize my data since I never liked the syntax and style of base plots in R. Because I was short on time, I plotted these figures by try’n’error and with the help of lots of googling. The resource I came always back to was a blog entry called Beautiful plotting in R: A ggplot2 cheatsheet by Zev Ross..
After giving the talk which contained some quite beautiful plots thanks to the blog post, I decided to go through this tutorial step-by-step. I learned so much from it and directly started modifying the codes and over the time I added some additional code snippets, chart types and resources.

Since the blog entry by Zev Ross was not updated for some years, I hosted the updated version (last update Jan 2017) on my GitHub. Now it finds its proper place on this homepage! (Plus I added some updates, for example the fantastic patchwork package. And pie charts because everyone looooves pie charts!)

Some major changes I’ve made:

* to follow the R style guide (e.g. by Hadley Wickham, Google or the Coding Club style guides),
* to change style and aesthetics of plots (e.g. axis titles, legends and nice colors for all plots not only some),
* to have a updated version which keeps track of changes in `ggplot2`,
* to modify data import (GitHub source),
* to have an executable R script for exercises and workshops
* to include additional tipps on e.g:
    + other plot types (e.g. contour plot, rug representation, ridge plot)
    + how and why to use the viridis color palettes
    + creating minimal plots using the Tufte plotting style
    + how to adjust the plots title, subtitle and caption
    + how to add different types of lines to a plot
    + how to change the order in a legend and legend key names
    + how to add labels to your data (and how to do it in a beautiful way)

## The `ggplot2` Package

> ggplot2 is a system for declaratively creating graphics, based on [The Grammar of Graphics](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448/ref=as_li_ss_tl?ie=UTF8&qid=1477928463&sr=8-1&keywords=the+grammar+of+graphics&linkCode=sl1&tag=ggplot2-20&linkId=f0130e557161b83fbe97ba0e9175c431). You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.

Consequently, a ggplot is built up from a few basic elements:

1.	**Data**:  
The raw data that you want to plot.
2.	**Geometries** `geom_`:  
The geometric shapes that will represent the data.
3.	**Aesthetics** `aes()`:  
Aesthetics of the geometric and statistical objects, such as color, size, shape, transparency and position.
4.	**Scales** `scale_`:  
Maps between the data and the aesthetic dimensions, such as data range to plot width or factor values to colors.
5.	**Statistical transformations** `stat_`:  
Statistical summaries of the data, such as quantiles, fitted curves and sums.
6.	**Coordinate system** `coord_`:  
The transformation used for mapping data coordinates into the plane of the data rectangle.
7.	**Facets** `facet_`:  
The arrangement of the data into a grid of plots.
8.	**Visual themes** `theme()`:  
The overall visual defaults of a plot, such as background, grids, axes, default typeface, sizes and colors.

## Table of Content

* Working with Axes
* Working with Titles
* Working with Legends
* Working with Backgrounds & Grid Lines
* Working with Margins
* Working with Multi-Panel Plots
* Working with Themes
* Working with Colors
* Working with Lines
* Working with Text
* Working with Coordinates
* Working with Chart Types
* Working with Ribbons (AUC, CI, etc.)
* Working with Smoothings
* Working with Interactive Plots
