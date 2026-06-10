class_name GameSnapshot
extends RefCounted

static func snapshot(state: GameState, events: Array) -> Dictionary:
	var players_data: Array = []
	for player in state.players:
		var resources := {}
		for resource in ResourceType.all():
			resources[ResourceType.to_key(resource)] = player.get_resource(resource)
		players_data.append({
			"id": player.id,
			"name": player.display_name,
			"resources": resources,
		})

	var events_data: Array = []
	for event in events:
		if event is GameEvent:
			events_data.append(event.to_dict())

	return {
		"seed": state.seed,
		"turn_number": state.turn_number,
		"players": players_data,
		"events": events_data,
	}
