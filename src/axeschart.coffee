class AxesChart
	# AxesChart is a chart that has the padding and a couple of axes on it.
	constructor: ->
		@_width  = 800
		@_height = 600

		@_margin = {
			top: 50
			left: 50
			bottom: 50
			right: 50
		}

		@_colours = [ 
			"#E41A1C"
			"#377EB8"
			"#4DAF4A"
			"#984EA3"
			"#FF7F00"
			"#FFFF33"
			"#A65628"
			"#F781BF"
			"#999999"
		]
		

	draw: =>
		# setup the canvas
		@setup()
		# do any stuff that needs to be recalculated before drawing
		@predraw()
		# this bit does the drawing on each selection
		@selection.each( (d, i) => @_draw(d, i))
		# do any stuff that needs to be done after drawing
		@postdraw()

	setup: () ->
		# setup the plot, make a plotarea with margins.
		@selection = d3.select(@_el)
		@selection.datum(@_data)
		@_canvas = @selection.append("svg")
					.attr("width", @_width + @_margin.left + @_margin.right)
					.attr("height", @_height + @_margin.top + @_margin.bottom)

		@_plotarea = @_canvas.append("g")
						.attr("transform", "translate(#{@_margin.left}, #{@_margin.top})")


	_draw: (d, i) ->
		throw "Not implemented"

	predraw: () ->
		# calculate any stuff that needs to be done before drawing. re-implement if this is needed, if not then just leave

	postdraw: () ->
		# calculate any stuff that needs to be done after drawing. re-implement if this is needed, if not then just leave

	# getters and setters
	el: (value) ->
		# the plot element
		if not arguments.length
			return @_el
		@_el = value
		@

	data: (value) ->
		# the plot data
		if not arguments.length
			return @_data
		@_data = value
		@

	width: (value) ->
		# plot width
		if not arguments.length
			return @_width
		@_width = value
		@

	height: (value) ->
		if not arguments.length
			return @_height
		@_height = value
	
		@

	margin: (value) ->
		if not arguments.length
			return @_margin
		@_margin = value
		@

	xscale: (value) ->
		if not arguments.length
			return @_xscale
		@_xscale = value
		@

	yscale: (value) ->
		if not arguments.length
			return @_yscale
		@_yscale = value
		@

	# accessor functions that get access to the scales

	x: (i)->
		if not @_xscale?
			return i
		@_xscale(i)
	
	y: (i)->
		if not @_yscale?
			return i
		@_yscale(i)

	colour: (i) ->
		# colour scale function
		# if the levels haven't been defined, calculate them
		if not @levels?
			@levels = _.uniq( _.pluck @data(), "group" )
			console.log(@levels)

		# return the colour lookup
		@_colours[_.indexOf @levels, i]

	xaxis: () ->
		# create the x-axis svg element and position it correctly
		if @_xscale?
			if not @_xaxis?
				@_xaxis = d3.svg.axis()
							.scale(@_xscale)
							.orient("bottom")

			# calculate how much to move the x axis by
			@_plotarea.append("g")
				.attr("class", "x axis")
				.attr("transform", "translate(0, #{@_height})")
				.call(@_xaxis)

	yaxis: () ->
		# create the y-axis svg element and position it correctly.
		if @_yscale?
			if not @_yaxis?
				@_yaxis = d3.svg.axis()
							.scale(@_yscale)
							.orient('left')
			@_plotarea.append("g")
				.attr("class", "y axis")
				.call(@_yaxis)



class ScatterPlot extends AxesChart
	constructor: (pointsize = 5) ->
		super
		@_pointsize = pointsize


	_draw: (d, i)  ->
		@_plotarea.selectAll("circle")
			.data(d)
			.enter()
			.append("circle")
				.attr("r", @_pointsize)
				.attr("cx", (d) => @x(d.x))
				.attr("cy", (d) => @y(d.y))
				.attr("fill", (d) => @colour(d.group))

	postdraw: () ->
		@xaxis()
		@yaxis()

class BubblePlot extends AxesChart
	constructor: (maxpointsize = 20) ->
		super
		@_maxpointsize = maxpointsize

	predraw: () ->
		extent = d3.extent(_.pluck @data(), "z")
		@radiusscale = d3.scale.linear()
							.domain(extent)
							.range([5, @_maxpointsize])

	postdraw: () ->
		@xaxis()
		@yaxis()

	_draw: (d, i) ->
		@_plotarea.selectAll("circle")
			.data(d)
			.enter()
			.append("circle")
				.attr("r", (d) => Math.pow(@radiusscale(d.z), 1/2)*Math.PI)
				.attr("cx", (d) => @x(d.x))
				.attr("cy", (d) => @y(d.y))
				.attr("fill", (d) => @colour(d.group))


class LinePlot extends AxesChart
	_draw: (d, i) ->
		series = _.pairs(_.groupBy(@_data, 'group'))
		if not @line?
			line = d3.svg.line()
					.interpolate("linear")
					.x( (d) => @x(d.x) )
					.y( (d) => @y(d.y) )

		console.log series

		@_plotarea.selectAll('.dataline')
			.data(series)
			.enter()
			.append("path")
			.attr("class", "dataline")
			.attr("d", (d) -> line d[1])
			.attr("stroke", (d) => @colour(d[0]))

	postdraw: () ->
		@xaxis()
		@yaxis()
