class_name BotTurnResolver
extends RefCounted

static func resolve_player_turn(state: GameState) -> Array:
	var events: Array = []

	while true:
		var choice := BotPolicy.choose_action(state)
		if choice.kind == ActionKind.Kind.END_TURN:
			events.append_array(ActionRules.apply(state, choice))
			break
		events.append_array(ActionRules.apply(state, choice))

	return events
