class_name HexTile
extends RefCounted

var coord: HexCoord
var production: Dictionary = {}


func _init(p_coord: HexCoord) -> void:
	coord = p_coord
	for resource in ResourceType.all():
		production[resource] = 0.0


func get_production(resource: ResourceType.Type) -> float:
	return production.get(resource, 0.0)
