class_name GameState
extends RefCounted

var seed: int = 0
var turn_number: int = 0
var rng: GameRng = GameRng.new()
var board: HexBoard
var action_space: ActionSpace
var players: Array[Player] = []
var cities: Array[City] = []
var cities_by_vertex: Dictionary = {}
