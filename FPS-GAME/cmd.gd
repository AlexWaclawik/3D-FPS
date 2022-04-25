# credit: https://github.com/rhulha/quake3-movement-godot/blob/main/QuakeMovement/Character/cmd.gd

extends Node

var forwardmove : Vector3 setget _set_forwardMove, _get_forwardMove
var rightmove : Vector3 setget _set_rightMove, _get_rightMove
var upmove : Vector3 setget _set_upMove, _get_upMove

func _get_forwardMove():
	return forwardmove
	
func _set_forwardMove(Newforwardmove):
	forwardmove = Newforwardmove

func _get_rightMove():
	return rightmove

func _set_rightMove(Newrightmove):
	rightmove = Newrightmove

func _get_upMove():
	return upmove

func _set_upMove(Newupmove):
	upmove = Newupmove
