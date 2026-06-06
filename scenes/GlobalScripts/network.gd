extends Node

const Default_port = 4242
const Max_Clients = 10

var server = null
var client = null

var ip_address = ""

func _ready():
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[3]
	elif OS.get_name() == "Android":
		ip_address = IP.get_local_addresses()[0]
	else:
		ip_address = IP.get_local_addresses()[3]
		
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_address = ip
			
	get_tree().connect("connected_to_server", Callable(self, "_connected_to_server"))
	get_tree().connect("server_disconnected", Callable(self, "_server_disconnected"))
	get_tree().connect("connection_failed", Callable(self, "_connection_failed"))

func create_server()->void:
	server = ENetMultiplayerPeer.new()
	server.create_server(Default_port,Max_Clients)
	get_tree().set_multiplayer_peer(server)
	
func join_server()->void:
	client = ENetMultiplayerPeer.new()
	client.create_client(ip_address,Default_port)
	get_tree().set_multiplayer_peer(client)
	

func _connected_to_server()->void:
	print("successfully connected") 
	
func _server_disconnected()->void:
	print("dis connected from server") 
	
