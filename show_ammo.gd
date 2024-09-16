extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Dostępna amunicja: 12"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_ammo(ammo):
	text = "Dostępna amunicja: " + str(ammo)
