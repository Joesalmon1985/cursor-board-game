class_name BotTurnResolver
extends RefCounted

static func resolve_player_turn(state: GameState, event_log: EventLog = null) -> Array:
	var events: Array = []

	while true:
		if event_log != null:
			var view := LegalActionQuery.get_view(state)
			event_log.append_legal_mask(
				view,
				state.round_number,
				TurnRules.get_active_player_id(state)
			)

		var choice := BotPolicy.choose_action(state)
		var applied := ActionRules.apply(state, choice)
		for event in applied:
			events.append(event)
			if event_log != null:
				event_log.append(event)

		if choice.kind == ActionKind.Kind.END_TURN:
			break

	return events
