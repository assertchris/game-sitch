extends CenterContainer
tool

signal pressed

export var label := "button"
export var image_0: Texture
export var image_1: Texture
export var image_2: Texture
export var image_3: Texture

onready var _texture := $Texture
onready var _label := $Label

func _ready() -> void:
	randomize()

	var image_number = randi() % 4
	var image_texture = get("image_" + str(image_number))

	_texture.texture_normal = image_texture
	_texture.texture_disabled = image_texture
	_texture.texture_hover = image_texture

func _process(_delta: float) -> void:
	if _label:
		_label.text = label

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("pressed")
