extends Node3D

const SPEED = 30.0 

@onready var mesh =  $MeshInstance3D
@onready var ray = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position -= Vector3(-2.7, 12.5, 0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += global_transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		mesh.visible = false
		print("Uderzyłem w coś")
		if ray.get_collider().is_in_group("enemy"):
			print("Uderzyłem w przeciwnika")
			hit(ray.get_collider())
		queue_free()

func hit(enemy_id):
	print("zadano obrażenia -> ", enemy_id)
	enemy_id.call("hurt_enemy", 5)	#wywołanie metody dla obiektu o danym id
