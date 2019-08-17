# ggplot2 Tutorial

Author: Cédric Scherer (cedricphilippscherer@gmail.com)

**You can find the latest version on my [homepage](https://cedricscherer.netlify.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/).**

The initial version of this tutorial follows a blog entry called [**Beautiful plotting in R: A ggplot2 cheatsheet**](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/) by zev@zevross.com, posted on 4. August 2014, updated last in January 2016.

![./img/overview.png](https://github.com/Z3tt/R-Tutorials/blob/master/ggplot2/img/overview.png)

### Introductory Words

Begin of 2016, I had to prepare my PhD introductory talk and I started using `ggplot2` to visualize my data since I never liked the syntax and style of base plots in R. Because I was short on time, I plotted these figures by try’n’error and with the help of lots of googling. The resource I came always back to was a blog entry called Beautiful plotting in R: A ggplot2 cheatsheet by Zev Ross..

After giving the talk which contained some quite beautiful plots thanks to the blog post, I decided to go through this tutorial step-by-step. I learned so much from it and directly started modifying the codes and over the time I added some additional code snippets, chart types and resources.

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

Since the blog entry by Zev Ross was not updated for some years, I hosted the updated version (last update Jan 2017) on my GitHub. Now it finds its proper place on this homepage! (Plus I added some updates, for example the fantastic patchwork package. And pie charts because everyone looooves pie charts!)
