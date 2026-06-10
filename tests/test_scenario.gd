class_name TestScenario
extends RefCounted

const STARTING_RESOURCES := {
	ResourceType.Type.WOOD: 4,
	ResourceType.Type.BRICK: 2,
	ResourceType.Type.WHEAT: 2,
	ResourceType.Type.SHEEP: 0,
	ResourceType.Type.ORE: 0,
}


static func build_standard_game(game_seed: int) -> GameState:
	var state := _create_players_and_cities(game_seed)
	return state


static func build_bot_ready_game(game_seed: int) -> GameState:
	var state := _create_players_and_cities(game_seed)
	for player in state.players:
		SetupRules.grant_resources(state, player.id, STARTING_RESOURCES)
	return state


static func _create_players_and_cities(game_seed: int) -> GameState:
	var state := SetupRules.create_game(game_seed)
	SetupRules.add_player(state, "Alice")
	SetupRules.add_player(state, "Bob")

	var alice_vertex := VertexCoord.from_hex_corner(HexCoord.new(0, 0), 0)
	var bob_vertex := VertexCoord.from_hex_corner(HexCoord.new(1, 0), 2)
	SetupRules.place_city(state, 0, alice_vertex)
	SetupRules.place_city(state, 1, bob_vertex)
	return state


static func run_production_rounds(state: GameState, rounds: int) -> Array:
	var all_events: Array = []
	for _i in range(rounds):
		all_events.append_array(ProductionRules.resolve_start_of_turn_production(state))
	return all_events
