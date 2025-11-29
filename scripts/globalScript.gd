extends Node

var playerCurrentAttack = false

var currentScene = 'world'
var cliffTransitionScene = false
var candyTransitionScene = false

var playerExitCliffPosx = 663
var playerExitCliffPosy = 21

var playerExitCandyPosx = 640
var playerExitCandyPosy = 612

var playerStartPosx = 41
var playerStartPosy = 40

var gameFirstLoads = true
var cliffExit = false
var candyExit = false

func finishChangingSceneCliff():
	if cliffTransitionScene == true:
		cliffTransitionScene = false
		if currentScene == 'world':
			currentScene = 'cliff_side'
		else:
			currentScene = 'world'

func finishChangingSceneCandy():
	if candyTransitionScene == true:
		candyTransitionScene = false
		if currentScene == 'world':
			currentScene = 'candy'
		else:
			currentScene = 'world'
