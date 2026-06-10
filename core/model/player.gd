class_name Player
extends RefCounted

var id: int
var display_name: String
var resources: Dictionary = {}


func _init(p_id: int, p_display_name: String) -> void:
	id = p_id
	display_name = p_display_name
	for resource in ResourceType.all():
		resources[resource] = 0


func get_resource(resource: ResourceType.Type) -> int:
	return resources.get(resource, 0)


func add_resource(resource: ResourceType.Type, amount: int) -> void:
	resources[resource] = get_resource(resource) + amount
