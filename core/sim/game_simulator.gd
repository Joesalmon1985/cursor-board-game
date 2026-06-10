class_name GameSimulator
extends RefCounted

static func run(game_seed: int, rounds: int) -> Dictionary:
	var state := ScenarioBuilder.build_bot_ready_game(game_seed)
	var events: Array = []
	events.append_array(GameStartRules.start_game(state))

	for _round_index in range(rounds):
		for _player_index in range(TurnRules.player_count(state)):
			events.append_array(BotTurnResolver.resolve_player_turn(state))

	return {
		"state": state,
		"events": events,
		"snapshot": GameSnapshot.snapshot(state, events),
	}
