extends Node

class_name TimerCustom

var test
var timeee
var pla
var index = []

func Time(time, plaa, indexx=null):
	timeee = Timer.new()
	pla = plaa
	timeee.wait_time = time
	timeee.one_shot = true
	var _l = timeee.connect("timeout", self, "_on_timer_timeout")
	pla.add_child(timeee)
	timeee.name = "Timer " + pla.name + " " +str(time)
	if indexx != null: index.append(indexx)
	timeee.start()

func _on_timer_timeout():
	if index.size() != 0:
		for i in index.size():
			pla.states[index[i]] = !pla.states[index[i]]
	timeee.queue_free()
