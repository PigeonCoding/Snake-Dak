extends KinematicBody2D

var states = [true]

signal ate

onready var snakebodyholder = $"../snakebodyholder"
onready var foodholder = $"../foodholder"
onready var dedLabel = $"../Control/ded"
onready var scoreLabel = $"../Control/Score"

var snakeBody = load("res://prefabs/snakeBody.tscn")

var ded = false

var dir = 0
var velocity = Vector2()
var cellSize = 20

var duration = 13.0

var lastPos = []
var size = 2

func _ready():
	lastPos.push_back(global_position)
	# pass
	var snakk = snakeBody.instance()
	snakk.global_position = lastPos[-1]
	snakebodyholder.add_child(snakk)

func _process(_delta):
	
	if global_position.x > get_viewport().get_visible_rect().size.x or global_position.x < 0:
		ded = true
	if global_position.y > get_viewport().get_visible_rect().size.y or global_position.y < 0:
		ded = true

	if Input.is_action_pressed("ui_select") and ded:
		var _p = get_tree().reload_current_scene()

	scoreLabel.text = str(size - 2)
	
	if ded:
		dedLabel.visible = true
	
	if Input.is_action_just_pressed("up"):
		dir = 1
	if Input.is_action_just_pressed("down"):
		dir = -1
	if Input.is_action_just_pressed("left"):
		dir = -2
	if Input.is_action_just_pressed("right"):
		dir = 2
		
	if states[0] and !ded:
		delete_children(snakebodyholder)
		if dir == 1:
			velocity.y = -cellSize
			velocity.x = 0
		if dir == -1:
			velocity.y = cellSize
			velocity.x = 0
		if dir == 2:
			velocity.x = cellSize
			velocity.y = 0
		if dir == -2:
			velocity.x = -cellSize
			velocity.y = 0
		
		global_position += velocity
		
		if foodholder.get_children().size() > 0:
			for u in foodholder.get_children():
				if global_position == u.global_position:
					size += 1
					duration -= 0.002
					emit_signal("ate")
					
		for i in size:
			if i <= lastPos.size() and i > 0:
				var snakk = snakeBody.instance()
				snakk.name = "boo"
				snakk.global_position = lastPos[-i]
				snakebodyholder.add_child(snakk)
				
		if dir != 0 and velocity.length() > 0:
			for t in lastPos.size():
				if t <= size and t > 2:
					if global_position == lastPos[-t]:
						ded = true
			
			lastPos.push_back(global_position)
			states[0] = false
			time(duration, 0)

func time(durationTime, index):
	var timer = TimerCustom.new()
	timer.Time(durationTime / 100, self, index)

static func delete_children(node):
	for n in node.get_children():
		n.queue_free()
