extends Node

var playerCurrentAttack = false

var currentScene = 'world'
var transitionScene = false

var playerExitCliffPosx = 663
var playerExitCliffPosy = 21

var playerStartPosx = 41
var playerStartPosy = 40

var gameFirstLoads = true

func finishChangingScene():
	if transitionScene == true:
		transitionScene = false
		if currentScene == 'world':
			currentScene = 'cliff_side'
		else:
			currentScene = 'world'
