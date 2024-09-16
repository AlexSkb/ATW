extends Node3D

const SPEED = 30.0 
const LIFESPAN = 15.0

@onready var mesh =  $MeshInstance3D
@onready var ray = $RayCast3D

var time_alive = 0.0
var sparks = preload("res://Sparks.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position -= Vector3(-2.7, 12.5, 0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += global_transform.basis * Vector3(0, 0, -SPEED) * delta
	
	#if time_alive < 0.01:
		#$AudioShoot.play()
	
	
	time_alive += delta
	if time_alive > LIFESPAN:
		queue_free()
	
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
	queue_free()
