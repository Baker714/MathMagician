extends Node2D


# Called when the node enters the scene tree for the first time.
@export var currentWeight: Label = null
@export var weightGoal: Label = null
@export var timer: Label = null
@export var moneyMade: Label = null
@export var currentLevel: Label = null

@export var successBanner: Container = null
@export var failureBanner: Container = null
@export var pauseMenu: Container = null

@export var addButton: Button = null
@export var subtractButton: Button = null
@export var multiplyButton: Button = null
@export var divideButton: Button = null
@export var squareButton: Button = null

@export var weightBlock: Node2D = null

var correctWeight = false
var rng = RandomNumberGenerator.new()
static var money = 0
static var level = 0
static var maxWeightGoal = 30
static var minWeightGoal = 10
static var timerLength = 10

var worryTime = false

func _ready():
	level += 1
	currentLevel.text = 'Lvl ' + str(level)
	
	get_tree().paused = false
	
	if level % 4 == 0: 
		maxWeightGoal *= 4
		minWeightGoal *= 4
		timerLength += 10
	
	if level > 3:
		multiplyButton.visible = true
		divideButton.visible = true
		
	if level > 6:
		squareButton.visible = true
	
	weightGoal.text = str(rng.randi_range(minWeightGoal, maxWeightGoal))
	currentWeight.text = str(rng.randi_range(1, 9))
	changeSize()
	moneyMade.text = '$' + str(money)
	$Timer.wait_time = timerLength
	$Timer.start()
	
func _process(delta):
	timer.text = str(int($Timer.time_left) + 1)
	
	if Input.is_key_pressed(KEY_ESCAPE):
		pauseMenu.visible = !pauseMenu.visible
		$Timer.paused = !$Timer.paused
		get_tree().paused = !get_tree().paused
		
	if int($Timer.time_left) == timerLength / 3 and !worryTime:
		worryTime = true
		$MainTheme.stop()
		$WorryTheme.play()
		

func _on_add_button_pressed():
	currentWeight.text = str(int(currentWeight.text) + int(addButton.text))
	changeSize()
	
func _on_subtract_button_pressed():
	var result = int(currentWeight.text) - int(subtractButton.text)
	if result < 0:
		result = 0
	currentWeight.text = str(result)
	changeSize()

func _on_multiply_button_pressed():
	currentWeight.text = str(int(currentWeight.text) * int(multiplyButton.text))
	changeSize()

func _on_divide_button_pressed():
	currentWeight.text = str(int(currentWeight.text) / int(divideButton.text))
	changeSize()

func _on_submit_button_pressed():
	if currentWeight.text == weightGoal.text:
		$Timer.paused = true
		successBanner.visible = true
		money += int($Timer.time_left)
		get_tree().paused = true
		$CompleteTheme.play()
	else:
		$WrongAnswerTheme.play()

func _on_clear_button_pressed():
	currentWeight.text = '0'
	changeSize()
	
func changeSize():
	var newScale = 1 + (float(currentWeight.text) / 100)
	
	if int(currentWeight.text) == 0:
		newScale = 0

	weightBlock.set_scale(Vector2(newScale, newScale))


func _on_next_level_button_pressed():
	get_tree().reload_current_scene()


func _on_timer_timeout():
	timer.text = '0'
	$Timer.stop()
	failureBanner.visible = true
	get_tree().paused = true
	$FailTheme.play()
	if money != 0:
		money -= 10

func _on_continue_button_pressed():
	pauseMenu.visible = !pauseMenu.visible
	$Timer.paused = !$Timer.paused
	get_tree().paused = !get_tree().paused

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_quit_game_button_pressed():
	get_tree().quit()

func _on_square_button_pressed():
	currentWeight.text = str(int(currentWeight.text) * int(currentWeight.text))
	changeSize()
