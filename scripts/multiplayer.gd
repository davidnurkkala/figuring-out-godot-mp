extends Node

const PORT = 8080

var ip = "ec2-3-15-160-206.us-east-2.compute.amazonaws.com"

func _ready():
	$Gui/Buttons/HostButton.pressed.connect(host_server)
	$Gui/Buttons/ConnectButton.pressed.connect(connect_to_server)
	$Gui/Buttons/ConnectLocal.pressed.connect(connect_local)
	
	multiplayer.server_relay = false
	
	if OS.has_feature("dedicated_server"):
		host_server()

func host_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start server")
		return
	multiplayer.multiplayer_peer = peer
	start_game()

func connect_local():
	ip = "127.0.0.1"
	connect_to_server()

func connect_to_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start client")
		return
	multiplayer.multiplayer_peer = peer
	start_game()
	
func start_game():
	$Gui.hide()
	
	if multiplayer.is_server():
		change_level.call_deferred(load("res://levels/level1.tscn"))
	
func change_level(scene: PackedScene):
	var level_container = $Level
	for child in level_container.get_children():
		level_container.remove_child(child)
		child.queue_free()
	level_container.add_child(scene.instantiate())
