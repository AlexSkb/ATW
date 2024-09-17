extends Node3D
@onready var ray = $RayCast3D
var can_buy_ammo = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray.is_colliding():
		var obiekt = ray.get_collider() 	#obiektem którego kolizja jest wykrywana jest $ball
		if ray.get_collider() != null :
			print("Nie Null")
			if ray.get_collider().is_in_group("hero"):
				print("zderzenie gracza z beczką do kupienia amunicji")
				if can_buy_ammo:
					obiekt.call("buy_ammo")
					can_buy_ammo = false
					$MeshInstance3D.visible = false
					$Timer.start(30)

func _on_timer_timeout() -> void:
	can_buy_ammo = true
	$MeshInstance3D.visible = true
	$Timer.stop()
