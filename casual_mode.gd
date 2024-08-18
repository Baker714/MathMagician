extends Node2D


# Called when the node enters the scene tree for the first time.
@export var currentWeight: Label = null
@export var weightGoal: Label = null

@export var moneyMade: Label = null

@export var successBanner: Container = null
@export var failureBanner: Container = null
@export var pauseMenu: Container = null

@export var addButton: Button = null
@export var subtractButton: Button = null
@export var multiplyButton: Button = null
@export var divideButton: Button = null

@export var weightBlock: Node2D = null

var correctWeight = false
var rng = RandomNumberGenerator.new()
static var money = 0

func _ready():
	get_tree().paused = false
	weightGoal.text = str(rng.randi_range(0, 200))
	currentWeight.text = str(rng.randi_range(1, 9))
	changeSize()
	moneyMade.text = '$' + str(money)
	
func _process(delta):	
	if Input.is_key_pressed(KEY_ESCAPE):
		pauseMenu.visible = !pauseMenu.visible
		get_tree().paused = !get_tree().paused

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
		successBanner.visible = true
		get_tree().paused = true

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


func _on_continue_button_pressed():
	pauseMenu.visible = !pauseMenu.visible
	get_tree().paused = !get_tree().paused

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_quit_game_button_pressed():
	get_tree().quit()
