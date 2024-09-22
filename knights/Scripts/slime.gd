extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null
@onready var animated_sprite_2d = $AnimatedSprite2D

var health = 100
var player_in_attack_range = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		move_and_collide(Vector2(0,0))
		
		if (player.position.x - position.x) < 0:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.flip_h = true
			
		elif (player.position.x - position.x) > 0:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.flip_h = false
						
	else:
		animated_sprite_2d.play("idle")

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_range = false
		
func deal_with_damage():
	if player_in_attack_range and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ",health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
