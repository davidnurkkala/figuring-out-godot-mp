GDPC                                                                                          P   res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.res�       '      Ƥ�qv`E�yv�Bu�    P   res://.godot/exported/206107301/export-3070c538c03ee49b7677ff960a3f5195-main.scn�!      #      �����S���Gs"&X    T   res://.godot/exported/206107301/export-3487d0e401bd2ba38190306100507795-face1.res          '      DB���:�������!    T   res://.godot/exported/206107301/export-b4587a2a7cb4026c0e83dd630b893882-level1.scn  0      �      ��CQ�"g˘�����    X   res://.godot/exported/206107301/export-b6bd7a241034177d7fe082a7597ba8ea-character.scn          6
      �:�7ě�$���Ӻ    ,   res://.godot/global_script_class_cache.cfg  `(             ��Р�8���8~$}P�       res://.godot/uid_cache.bin  @,      �       �6@8�t3�AE��U�       res://icon.svg  �(      �      k����X3Y���f       res://icon.svg.import   �      �       p��?�z��i@��.�1M        res://images/face1.png.import           �       �+����H�b�HP�        res://levels/level1.tscn.remap  '      c       Q�#'n-Ѡ�W� �1[\       res://main.tscn.remap   �'      a       �gV��J=����ܒ       res://project.binary�,      
      9�F:�N*�25J�S    $   res://scenes/character.tscn.remap   �'      f       a��#n�@W�����}л       res://scripts/character.gd  @      �      �_8��r2�.S���(       res://scripts/level.gd  �      R       ��|�k�XFi�c       res://scripts/multiplayer.gd0      �      ��0Ì�g
�q�����        [remap]

importer="texture"
type="PlaceholderTexture2D"
uid="uid://cus7e6vutyr1t"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
path="res://.godot/exported/206107301/export-3487d0e401bd2ba38190306100507795-face1.res"
                RSRC                    PlaceholderTexture2D            ��������                                                  resource_local_to_scene    resource_name    size    script        #   local://PlaceholderTexture2D_wiyu7 �          PlaceholderTexture2D       
      B   B      RSRC         RSRC                    PackedScene            ��������                                                  ..    Players    resource_local_to_scene    resource_name    lightmap_size_hint    aabb    script    custom_solver_bias    margin    plane 	   _bundled       Script    res://scripts/level.gd ��������      local://PlaceholderMesh_sw8qq �      #   local://WorldBoundaryShape3D_vqxxc          local://PackedScene_eugi7 +         PlaceholderMesh            ��      ��   B       B         WorldBoundaryShape3D             PackedScene    
      	         names "         World    script    Node3D    MultiplayerSpawner    _spawnable_scenes    spawn_path    Ground    StaticBody3D    Mesh    mesh    MeshInstance3D 
   Collision    shape    CollisionShape3D    DirectionalLight3D 
   transform    Players    Node    	   variants                 "         res://scenes/character.tscn                                    �5?   �   ?    �5?�5?�5�   �   ?      �A          node_count             nodes     =   ��������       ����                            ����                                 ����               
      ����   	                       ����                           ����                           ����              conn_count              conns               node_paths              editable_instances              version             RSRC          RSRC                    PackedScene            ��������                                                  . 	   position 	   rotation 
   player_id    Head    ..    resource_local_to_scene    resource_name    properties/0/path    properties/0/spawn    properties/0/replication_mode    properties/1/path    properties/1/spawn    properties/1/replication_mode    properties/2/path    properties/2/spawn    properties/2/replication_mode    properties/3/path    properties/3/spawn    properties/3/replication_mode    script    custom_solver_bias    margin    radius    height    lightmap_size_hint    aabb    size 	   _bundled       Script    res://scripts/character.gd ��������   %   local://SceneReplicationConfig_uxr5l �         local://CapsuleShape3D_owgnu �         local://PlaceholderMesh_i51cc �         local://PlaceholderMesh_irgty        #   local://PlaceholderTexture2D_0bxwo @         local://PackedScene_v7r6q u         SceneReplicationConfig                   	         
                                                                                                                    CapsuleShape3D             PlaceholderMesh            ��  ��  ��   ?   @   ?         PlaceholderMesh             �   �      �?  �?             PlaceholderTexture2D       
      B   B         PackedScene          	         names "         Player    script    CharacterBody3D    Synchronizer    replication_config    MultiplayerSynchronizer 
   Collision    shape    CollisionShape3D    Mesh    mesh    MeshInstance3D    Head 
   transform    Node3D    Face 	   skeleton    Decal    size    texture_albedo    Camera 	   Camera3D    	   variants                                                  �?              �?              �?      �?         ��    1��3      �?    1���      ��           �                          �����3/    �������1��3������:                 �?���=  �?              �?              �?              �?  �?       @      node_count             nodes     P   ��������       ����                            ����                           ����                        	   ����   
                        ����                          ����         
                             ����            	      
                    ����                   conn_count              conns               node_paths              editable_instances              version             RSRC          extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_SENSITIVITY = 0.01
const VERTICAL_SENSITIVITY = 0.01

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var tilt = 0
@onready var head_transform = $Head.transform

@export var player_id := 1:
	set(id):
		player_id = id
		set_multiplayer_authority(id)

func _ready():
	if player_id == multiplayer.get_unique_id():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		$Head/Camera.current = true
	else:
		set_physics_process(false)
		set_process_input(false)
		
func _input(event):
	if event is InputEventMouseMotion:
		transform = transform.rotated_local(Vector3.UP, -event.relative.x * HORIZONTAL_SENSITIVITY)
		tilt = clamp(tilt + -event.relative.y * VERTICAL_SENSITIVITY, -PI / 2, PI / 2)
		$Head.transform = head_transform.rotated_local(Vector3.RIGHT, tilt)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
  extends Node3D

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
              extends Node

const PORT = 8080

func _ready():
	$Gui/Buttons/HostButton.pressed.connect(host_server)
	$Gui/Buttons/ConnectButton.pressed.connect(connect_to_server)
	
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

func connect_to_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("ec2-3-15-160-206.us-east-2.compute.amazonaws.com", PORT)
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
             [remap]

importer="texture"
type="PlaceholderTexture2D"
uid="uid://4cffyf0r8lku"
metadata={
"vram_texture": false
}
path="res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.res"
    RSRC                    PlaceholderTexture2D            ��������                                                  resource_local_to_scene    resource_name    size    script        #   local://PlaceholderTexture2D_x8mca �          PlaceholderTexture2D       
      C   C      RSRC         RSRC                    PackedScene            ��������                                                  ..    Level    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/multiplayer.gd ��������      local://PackedScene_qm5ts %         PackedScene          	         names "         Multiplayer    script    Node    Level    LevelSpawner    _spawnable_scenes    spawn_path    MultiplayerSpawner    Gui    layout_mode    anchors_preset    offset_right    offset_bottom    Control    Buttons    HBoxContainer    HostButton    text    Button    ConnectButton    	   variants    	             "         res://levels/level1.tscn                                 B            Host Server       Connect to Server       node_count             nodes     M   ��������       ����                            ����                      ����                                 ����   	      
                                   ����   	                                   ����   	                             ����   	                      conn_count              conns               node_paths              editable_instances              version             RSRC             [remap]

path="res://.godot/exported/206107301/export-b4587a2a7cb4026c0e83dd630b893882-level1.scn"
             [remap]

path="res://.godot/exported/206107301/export-b6bd7a241034177d7fe082a7597ba8ea-character.scn"
          [remap]

path="res://.godot/exported/206107301/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              {M��f�BV   res://images/face1.png�_���aP   res://levels/level1.tscn�'@��{   res://scenes/character.tscn)ˆ?O   res://icon.svg��QW_�`   res://main.tscn          ECFG
      _custom_features         dedicated_server   application/config/name         StupidTestGame     application/run/main_scene         res://main.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     input/forward�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/backward�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script         