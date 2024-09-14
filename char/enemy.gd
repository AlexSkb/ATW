extends CharacterBody3D

var enemy_health = 20
const SPEED = 5.0
var hero
@export var turn_speed = 4.0

func _ready():
	hero = get_tree().get_nodes_in_group("hero")[1]		#pobranie modelu gracza
	

func _physics_process(delta: float) -> void:
	$FaceDirection.look_at(hero.global_transform.origin, Vector3.UP)
	rotate_y(deg_to_rad($FaceDirection.rotation.y*turn_speed))
	
	$NavigationAgent3D.set_target_position(hero.global_transform.origin)
	var velocity = ($NavigationAgent3D.get_next_path_position() - transform.origin).normalized() * SPEED * delta
	move_and_collide(velocity)


func _on_hit_player_area_body_entered(body: Node3D) -> void:
	get_tree().call_group("hero", "hurt", 10)
	pass # Replace with function body.
	
func hurt_enemy(hit_points):
	if hit_points < enemy_health:		#jeżeli otrzymany damage jest mniejszy od obecnych punktów zdrowia
		enemy_health -= hit_points	#odejmij otrzymane obrażenia od punktów zdrowia
	else:
		enemy_health = 0	#moment w którym otrzymany damage jest większy od obecnych punktów zdrowia
	if enemy_health == 0:	#jeżeli punkty zdrowia są zerowe 
		enemy_die()	#wywołaj funkcję die()	
		
func enemy_die():
	get_tree().call_group("hero", "points", 10)
	queue_free()
