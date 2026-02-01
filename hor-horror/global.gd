extends Node

var main : Main

var paused := false

# settings slider values
var fov : float
var master_vol : float
var sfx_vol : float
var ambient_vol : float
var sens_mod : float

func pause():
	paused = !paused
	get_tree().paused = paused
