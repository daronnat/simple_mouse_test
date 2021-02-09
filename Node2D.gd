extends Node2D

var DRAW = false
var TIME_START = false
var TIME_END = false

func _process(delta):
	var corrected_mouse_pos = Vector2(get_global_mouse_position().x-get_viewport().size.x,
		get_global_mouse_position().y-get_viewport().size.y/2)
	if DRAW == true:
		$start/Line2D.add_point(corrected_mouse_pos)

func compute_metrics():
	print($start/Line2D.get_point_count())
	var i = 0
	var all_y = []
	while i < $start/Line2D.get_point_count():
		
		all_y.append($start/Line2D.get_point_position(i).y)
		i += 1
	var result = variance(all_y)

func variance(data):
	var sum = 0
	for x in data:
		sum+=x
	var mean = sum/len(data)
	print("mean:",mean)
	
	var variance = 0
	for x in data:
		variance = pow(x-mean,2)
	
	variance = variance / len(data)
	print("variance:",variance)
	var elapsed_time = TIME_END-TIME_START
	$Label.text = "NBR of POINTS: "+str($start/Line2D.get_point_count())+"\nTIME: "+ str(elapsed_time)+"(ms)"+\
	"\nMEAN: "+str(mean)+"\nVARIANCE: "+str(variance)+"\n"

func _on_start_mouse_entered():
	DRAW = true
	$Label.text = "processing..."
	print("mouse entered")
	TIME_START = OS.get_ticks_msec()


func _on_end_mouse_exited():
	DRAW = false
	TIME_END = OS.get_ticks_msec()
	if $start/Line2D.get_point_count() > 0:
		compute_metrics()
		$start/Line2D.clear_points()
	print("mouse left")
	
