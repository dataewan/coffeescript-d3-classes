
data = [
	{x: 45, y:10, z:1, group: "one"}
	{x: 20, y:99, z:1, group: "one"}
	{x: 30, y:21, z:1, group: "one"}
	{x: 21, y:67, z:2, group: "two"}
	{x: 50, y:50, z:1, group: "three"}
	{x: 34, y:34, z:3, group: "four"}
	{x: 21, y:54, z:3, group: "three"}
	{x: 65, y:23, z:3, group: "four"}
	{x: 87, y:54, z:3, group: "three"}
	{x: 45, y:98, z:3, group: "four"}
	{x: 72, y:78, z:3, group: "three"}
	{x: 23, y:12, z:3, group: "four"}
]

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

# Constructor for the bubble plot. The 15 is a optional parameter that defines the maximum area of a bubble. 
# The scale runs from 5 to this max value. 
# It defaults to 20.
bubble = new BubblePlot(15)
bubble.width(800)
	 .height(600)
	 .el('div#bubbleplot')
	 .data(data)

bubble.xscale(d3.scale.linear()
				.domain([0, 100])
				.range([0, bubble.width()]))
bubble.yscale(d3.scale.linear()
				.domain([0, 100])
				.range([bubble.height(), 0]))
bubble.draw()

lineplot = new LinePlot(15)
lineplot.width(800)
	 .height(600)
	 .el('div#lineplot')
	 .data(data)

lineplot.xscale(d3.scale.linear()
				.domain([0, 100])
				.range([0, lineplot._width]))
lineplot.yscale(d3.scale.linear()
				.domain([0, 100])
				.range([lineplot._height, 0]))
lineplot.draw()

