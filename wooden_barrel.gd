extends Node3D
@onready var ray = $RayCast3D 
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
				print("zderzenie gracza z beczką")
				var random_item = randi_range(1, 4)
				if random_item == 1:
					obiekt.call("heal", 10)		#przekazanie do skryptu obiektu ball
					print("dodano zdrowie")
				if random_item == 2:
					obiekt.call("add_ammo", 5)
					print("dodano amunicję")
				if random_item == 3:
					print("znalazłeś pustą beczkę")
				if random_item == 4:
					obiekt.call("additional_points", 2)
					print("znalazłeś dodatkowe punkty")
				queue_free()
