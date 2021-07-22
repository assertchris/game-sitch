extends CenterContainer
tool

signal pressed

export var label := "button"
export (Array, Texture) var images
export var scale := 1.0

onready var _texture := $Texture
onready var _label := $Label

func _ready() -> void:
	randomize()

	var image_texture = images[randi() % images.size()]

	_texture.texture_normal = image_texture
	_texture.texture_disabled = image_texture
	_texture.texture_hover = image_texture

func _process(_delta: float) -> void:
	rect_scale = Vector2(scale, scale)

	if _label:
		_label.text = label

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("pressed")
			Sounds.play_sound(Constants.SOUNDS.BUTTON)
