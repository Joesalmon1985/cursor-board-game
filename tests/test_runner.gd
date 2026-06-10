extends SceneTree


func _init() -> void:
	var test_modules: Array = [
		TestBoardGeneration,
		TestVertexTopology,
		TestProduction,
		TestDeterminism,
		TestActionSpace,
		TestTurnOrder,
		TestLegalActions,
	]
	var test_assert := TestAssert.new()
	for module in test_modules:
		module.run(test_assert)

	if test_assert.has_failures():
		for failure in test_assert.failures:
			printerr("FAIL: %s" % failure)
		print("Tests failed: %d" % test_assert.failures.size())
		quit(1)
	else:
		print("All tests passed.")
		quit(0)
