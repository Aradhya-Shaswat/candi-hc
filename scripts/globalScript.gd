extends Node

var playerCurrentAttack = false

var currentScene = 'world'
var transitionScene = false

var playerExitCliffPosx = 0
var playerExitCliffPosy = 0

var playerStartPosx = 0
var playerStartPosy = 0

func finishChangingScene():
	if transitionScene == true:
		print('transitioned to cliffside')
		transitionScene = false
		if currentScene == 'world':
			currentScene = 'cliff_side'
		else:
			currentScene = 'world'
