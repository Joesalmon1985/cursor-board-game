class_name TestDeterminism
extends RefCounted

static func run(test_assert: TestAssert) -> void:
	var first := JSON.stringify(_run_scenario(42))
	var second := JSON.stringify(_run_scenario(42))
	test_assert.eq(first, second, "same seed should produce identical snapshots")

	var different := JSON.stringify(_run_scenario(43))
	test_assert.check(first != different, "different seeds should produce different snapshots")


static func _run_scenario(game_seed: int) -> Dictionary:
	var state := TestScenario.build_standard_game(game_seed)
	var events := TestScenario.run_production_rounds(state, 3)
	return GameSnapshot.snapshot(state, events)
