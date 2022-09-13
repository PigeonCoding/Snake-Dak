extends Node

var foodPrefab = load("res://prefabs/food.tscn")
onready var cellSize = $"../player".cellSize

var rand = RandomNumberGenerator.new()





func _ready():
	rand.randomize()
	var food = foodPrefab.instance()

	var maxX = get_viewport().get_visible_rect().size.x
	var maxY = get_viewport().get_visible_rect().size.y

	var X = rand.randi_range(cellSize, maxX)
	var Y = rand.randi_range(cellSize, maxY)
	
	var gud = false
	while !gud:
		if X % cellSize == 0 and Y % cellSize == 0 and X < maxX and Y < maxY:
			
			food.global_position = Vector2(X, Y)
			add_child(food)
			gud = true
		
		rand.randomize()
		
		X = rand.randi_range(cellSize, maxX)
		Y = rand.randi_range(cellSize, maxY)

func _on_KinematicBody2D_ate():
	
	delete_children($".")
	var food = foodPrefab.instance()
	
	var maxX = get_viewport().get_visible_rect().size.x
	var maxY = get_viewport().get_visible_rect().size.y

	rand.randomize()
	var X = rand.randi_range(cellSize, maxX)
	var Y = rand.randi_range(cellSize, maxY)
	
	var gud = false
	
	while !gud:
		if X % cellSize == 0 and Y % cellSize == 0:
			
			food.global_position = Vector2(X, Y)
			add_child(food)
			gud = true
		
		rand.randomize()
		
		X = rand.randi_range(cellSize, maxX)
		Y = rand.randi_range(cellSize, maxY)

static func delete_children(node):
	for n in node.get_children():
		n.queue_free()
