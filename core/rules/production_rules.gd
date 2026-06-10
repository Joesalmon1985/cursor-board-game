class_name ProductionRules
extends RefCounted

static func resolve_start_of_turn_production(state: GameState) -> Array:
	state.turn_number += 1
	return _resolve_production(state, state.turn_number)


static func resolve_round_production(state: GameState) -> Array:
	return _resolve_production(state, state.round_number)


static func _resolve_production(state: GameState, event_turn: int) -> Array:
	var events: Array = []
	var turn := event_turn

	for coord in state.board.get_all_coords_sorted():
		var tile := state.board.get_tile(coord)
		for resource in ResourceType.all():
			var threshold: float = tile.get_production(resource)
			if threshold <= 0.0:
				continue

			var roll := state.rng.randf()
			var produced := roll >= threshold
			events.append(ProductionCheckEvent.new(
				turn,
				coord,
				resource,
				threshold,
				roll,
				produced
			))

			if not produced:
				continue

			for vertex in state.board.get_vertices_for_hex(coord):
				var vertex_key := vertex.to_key()
				if not state.cities_by_vertex.has(vertex_key):
					continue

				var city: City = state.cities_by_vertex[vertex_key]
				var player := _get_player(state, city.player_id)
				if player == null:
					continue

				player.add_resource(resource, 1)
				events.append(ResourceGainedEvent.new(
					turn,
					player.id,
					resource,
					1,
					coord,
					vertex
				))

	return events


static func _get_player(state: GameState, player_id: int) -> Player:
	for player in state.players:
		if player.id == player_id:
			return player
	return null
