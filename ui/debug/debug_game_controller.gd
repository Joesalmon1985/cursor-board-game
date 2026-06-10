class_name DebugGameController
extends RefCounted

var _result: Dictionary = {}
var _step: int = 0


func get_result() -> Dictionary:
	return _result


func load_from_result(result: Dictionary) -> void:
	_result = result
	_step = 0


func load_simulation(game_seed: int, rounds: int) -> void:
	load_from_result(GameSimulator.run(game_seed, rounds))


func step_forward() -> void:
	var log: EventLog = _result.get("event_log")
	if log == null:
		return
	if _step < log.entries.size():
		_step += 1


func can_step() -> bool:
	var log: EventLog = _result.get("event_log")
	if log == null:
		return false
	return _step < log.entries.size()


func current_view() -> Dictionary:
	var state: GameState = _result.get("state")
	var log: EventLog = _result.get("event_log")
	return {
		"step": _step,
		"total_steps": log.entries.size() if log != null else 0,
		"round_number": state.round_number if state != null else 0,
		"active_player_index": state.active_player_index if state != null else 0,
		"players": _players_view(state),
		"board": _board_view(state),
		"events_text": _events_text(log),
	}


func _players_view(state: GameState) -> Array:
	var players_data: Array = []
	if state == null:
		return players_data
	for player in state.players:
		var resources := {}
		for resource in ResourceType.all():
			resources[ResourceType.to_key(resource)] = player.get_resource(resource)
		players_data.append({
			"id": player.id,
			"name": player.display_name,
			"resources": resources,
		})
	return players_data


func _board_view(state: GameState) -> Array:
	var cities_data: Array = []
	if state == null:
		return cities_data
	for city in state.cities:
		cities_data.append({
			"player_id": city.player_id,
			"vertex_key": city.vertex.to_key(),
		})
	return cities_data


func _events_text(log: EventLog) -> String:
	if log == null:
		return ""
	var lines: PackedStringArray = []
	for i in range(_step):
		var entry: Dictionary = log.entries[i]
		lines.append("#%d %s" % [entry["sequence_id"], entry["type"]])
	return "\n".join(lines)
