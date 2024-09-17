extends RigidBody3D
@onready var hero = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func heal(points):
	hero.call("heal", points)
	print("JESTEM TU")

func add_ammo(ammo):
	hero.call("add_ammo", ammo)

func additional_points(points):
	hero.call("points", points)

func buy_ammo():
	hero.call("try_buy_ammo")
	
