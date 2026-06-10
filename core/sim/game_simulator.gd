class_name GameSimulator
extends RefCounted

static func run(game_seed: int, rounds: int) -> Dictionary:
	var state := ScenarioBuilder.build_bot_ready_game(game_seed)
	var events: Array = []
	var event_log := EventLog.new()
	var replay_baseline := EventLogReplay.capture_baseline(state)

	var start_events := GameStartRules.start_game(state)
	for event in start_events:
		events.append(event)
		event_log.append(event)

	for _round_index in range(rounds):
		for _player_index in range(TurnRules.player_count(state)):
			events.append_array(BotTurnResolver.resolve_player_turn(state, event_log))

	return {
		"state": state,
		"events": events,
		"event_log": event_log,
		"replay_baseline": replay_baseline,
		"snapshot": GameSnapshot.snapshot(state, events, event_log),
	}
