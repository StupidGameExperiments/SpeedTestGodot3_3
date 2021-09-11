extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var primesTo = 1 setget setPrimesTo
var runLength = 1 setget setRunLength
const ps = preload("primeSieve.gd")
const resultScene = preload("res://Result.tscn")
var batch = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setPrimesTo(i : int):
	if i < 0:
		primesTo = 0 + 1
	elif i > 5:
		primesTo = 5 + 1
	else:
		primesTo = i + 1
	#print(primesTo)

func setRunLength(i : int):
	if i < 0:
		runLength = 0 + 1
	elif i > 4:
		runLength = 4 + 1
	else:
		runLength = i + 1
	#print(runLength)

func runSieve():
	batch += 1
	var psi = ps.new(pow(10,primesTo))
	var startTime = OS.get_ticks_msec()
	var count = 0
	while OS.get_ticks_msec() - startTime < runLength*1000:
		psi.run_sieve()
		count += 1
	var runTimeResult =  OS.get_ticks_msec() - startTime
	print(psi.count_primes())
	print (OS.get_ticks_msec() - startTime )
	var newResult = resultScene.instance()
	newResult.setText(batch,pow(10,primesTo),runLength*1000,runTimeResult,count)
	get_node("Panel/HBoxContainer/VBoxContainer2/SC_Results/VBoxContainer").add_child(newResult)
	newResult.size_flags_horizontal = SIZE_EXPAND_FILL
	
func quit():
	get_tree().quit()
