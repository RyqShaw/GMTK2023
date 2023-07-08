extends Camera2D

@export var SPEED = 20
@export var ZOOM_SPEED = 20
@export var ZOOM_MARGIN = 0.1
@export var ZOOM_MIN = 0.5
@export var ZOOM_MAX = 3

var zoomFactor = 1
var zoomPos = Vector2()
var zooming = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputX = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var inputY = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	position.x = lerp(position.x, position.x + inputX * SPEED * zoom.x, SPEED * delta)
	position.y = lerp(position.y, position.y + inputY * SPEED * zoom.y, SPEED * delta)

	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, ZOOM_SPEED * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, ZOOM_SPEED * delta)

	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)

	if not zooming:
		zoomFactor = 1


func _input(event):
	if abs(zoomPos.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoomFactor = 1
	if abs(zoomPos.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoomFactor = 1

	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.is_action("scroll_wheel_down"):
				zoomFactor -= 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
			if event.is_action("scroll_wheel_up"):
				zoomFactor += 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
		else:
			zooming = false
