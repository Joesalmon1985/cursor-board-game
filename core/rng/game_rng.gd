class_name GameRng
extends RefCounted

var _rng := RandomNumberGenerator.new()


func seed(value: int) -> void:
	_rng.seed = value


func randf() -> float:
	return _rng.randf()


func rand_range(from_value: float, to_value: float) -> float:
	return _rng.randf_range(from_value, to_value)


func randi_range(from_value: int, to_value: int) -> int:
	return _rng.randi_range(from_value, to_value)
