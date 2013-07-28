{exec} = require 'child_process'

listoffiles = "src/axeschart.coffee src/chartdemo.coffee"

task 'build', 'build files from the src/*.coffee to lib/*.js', ->
	exec 'coffee -j chart.js -c -o lib\\ ' + listoffiles, (err, stdout, stderr) ->
		throw err if err
		console.log stdout + stderr

task 'watch', 'watch for changes in files from the src/*.coffee to lib/*.js', ->
	exec 'coffee -w -j chart.js -c -o lib\\ ' + listoffiles, (err, stdout, stderr) ->
		throw err if err
		console.log stdout + stderr