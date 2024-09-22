extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attach_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false



const speed = 100
var current_dir = "none"
@onready var attack_cooldown = $Attack_cooldown


func _physics_process(delta):
	player_movemet(delta)
	enemy_attach()
	attack()
	
	if health <= 0:
		player_alive = false #add end screen
		health = 0
		print("You are dead")
		self.queue_free()
		
	
	
	
	#Basic movement + Animation
func player_movemet(delta):
	if Input.is_action_pressed("Right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
		
	elif Input.is_action_pressed("Left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
		
	elif Input.is_action_pressed("Down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	
	elif Input.is_action_pressed("Up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
			
			
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var animated_sprite_2d = $AnimatedSprite2D
	
	if dir == "right":
		animated_sprite_2d.flip_h = false
		if movement == 1:
			animated_sprite_2d.play("run_side")
		elif movement == 0:
			if attack_ip == false:
				animated_sprite_2d.play("idle_side")
	
	if dir == "left":
		animated_sprite_2d.flip_h = true
		if movement == 1:
			animated_sprite_2d.play("run_side")
		elif movement == 0:
			if attack_ip == false:
				animated_sprite_2d.play("idle_side")
			
	if dir == "down":
		if movement == 1:
			animated_sprite_2d.play("run_down")
		elif movement == 0:
			if attack_ip == false:
				animated_sprite_2d.play("idle_front")
			
	if dir == "up":
		if movement == 1:
			animated_sprite_2d.play("run_up")
		elif movement == 0:
			if attack_ip == false:
				animated_sprite_2d.play("idle_up")
			
			
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
func enemy_attach():
	if enemy_in_attack_range and enemy_attach_cooldown == true:
		health = health - 20
		enemy_attach_cooldown = false
		attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attach_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("Attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("attack_front")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("attach_up")
			$deal_attack_timer.start()
			

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
		

		


			
