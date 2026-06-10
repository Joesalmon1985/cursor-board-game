class_name ProductionCheckEvent
extends GameEvent

var turn: int
var hex: HexCoord
var resource: ResourceType.Type
var threshold: float
var roll: float
var produced: bool


func _init(
	p_turn: int,
	p_hex: HexCoord,
	p_resource: ResourceType.Type,
	p_threshold: float,
	p_roll: float,
	p_produced: bool
) -> void:
	event_type = "production_check"
	turn = p_turn
	hex = p_hex
	resource = p_resource
	threshold = p_threshold
	roll = p_roll
	produced = p_produced


func to_dict() -> Dictionary:
	return {
		"type": event_type,
		"turn": turn,
		"hex": hex.to_dict(),
		"resource": ResourceType.to_key(resource),
		"threshold": threshold,
		"roll": roll,
		"produced": produced,
	}
