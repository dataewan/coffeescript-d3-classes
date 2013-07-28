# Reusable charts using D3 and Coffeescript

Mike Bostock describes how to create [reusable charts using closures](http://bost.ocks.org/mike/chart/).

There is also this [gist](https://gist.github.com/dandavison/4152640) and [Google Groups discussion](https://groups.google.com/forum/#!msg/d3-js/0mG_lzRIJRc/8H5ogxkVo6sJ).

I think I prefer the class option (2 in the gist above). This is nicely integrated within Coffeescript.

And also [this tutorial](http://dealloc.me/2011/06/24/d3-is-not-a-graphing-library.html) uses D3 with Coffescript.


----

Goal here is to combine all the boilerplate code I use for D3 plots in one place so I don't need to repeat it all the time, abstracting the code into coffeescript classes.

## AxesChart

This is a super class for any chart that has padding and an x and y axis on it. This class by itself doesn't do anything, to make it draw a plot you need to subclass the `AxesChart` re-implement the `_draw` function.

Most of these examples use data that looks a bit like this.

```coffee
data = [
	{x: 45, y:10, z:1, group: "one"}
	{x: 20, y:99, z:1, group: "one"}
	{x: 30, y:21, z:1, group: "one"}
	{x: 21, y:67, z:2, group: "two"}
	{x: 50, y:50, z:1, group: "three"}
	{x: 34, y:34, z:3, group: "four"}
```

Where x is the value along the x axis, y is the value along the y axis, z is the third value - the size of a bubble on a bubble chart for example - and group is the colour.

If you want to see these in action then look at `chartdemo.coffee`.

### ScatterPlot

Simple scatterplot. Usage:

```coffee

# Constructor for the scatter plot. The 15 is an optional parameter which defines the size of the points. It defaults to 5 if you leave it out
scatter = new ScatterPlot(15)
# define the width and height of the scatter plot
scatter.width(800)
	 .height(600)
	 # define the html element to attach the plot to.
	 .el('div#scatterplot')
	 # give it the dataset
	 .data(data)

# set the xscale. This is a standard d3 scale linear, you could use anything you like
scatter.xscale(d3.scale.linear()
				.domain([0, 100])
				# get the value for the width of the plot by calling the width function with no arguments
				.range([0, scatter.width()]))

# the yscale is the same, just a standard d3 scale
scatter.yscale(d3.scale.linear()
				.domain([0, 100])
				.range([scatter.height(), 0]))
# call the draw function
scatter.draw()
```

### BubblePlot

Using the BubblePlot:

```coffee
# Constructor for the bubble plot. The 15 is a optional parameter that defines the maximum area of a bubble. 
# The scale runs from 5 to this max value. 
# It defaults to 20.
bubble = new BubblePlot(15)
# Define the height and width of the bubble plot
bubble.width(800)
	 .height(600)
	 # Attach it to a html element
	 .el('div#bubbleplot')
	 # give it the dataset
	 .data(data)

# Define the x and y scales - these are just standard d3 scales
bubble.xscale(d3.scale.linear()
				.domain([0, 100])
				.range([0, bubble.width()]))
bubble.yscale(d3.scale.linear()
				.domain([0, 100])
				.range([bubble.height(), 0]))
# call the draw function
bubble.draw()
```
### LinePlot

Usage of the LinePlot

```coffee
# Constructor for the line plot
lineplot = new LinePlot()
# define the width and height of the plot
lineplot.width(800)
	 .height(600)
	 # Attach it to a html element
	 .el('div#lineplot')
	 # Attach some data to it
	 .data(data)

# Define the x and y scales - these are just standard d3 scales
lineplot.xscale(d3.scale.linear()
				.domain([0, 100])
				.range([0, lineplot.width()]))
lineplot.yscale(d3.scale.linear()
				.domain([0, 100])
				.range([lineplot.height(), 0]))
# call the draw function
lineplot.draw()

```
