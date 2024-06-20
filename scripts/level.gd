extends Node3D

func _ready():
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	for id in multiplayer.get_peers():
		add_player(id)
	
	if not OS.has_feature("dedicated_server"):
		add_player(1)

func _exit_tree():
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(remove_player)

func add_player(id: int):
	var character = preload("res://scenes/character.tscn").instantiate()
	character.player_id = id
	character.position = Vector3(0, 5, 0)
	character.name = str(id)
	$Players.add_child(character, true)

func remove_player(id: int):
	var character_name := str(id)
	if not $Players.has_node(character_name):
		return
	$Players.get_node(character_name).queue_free()
