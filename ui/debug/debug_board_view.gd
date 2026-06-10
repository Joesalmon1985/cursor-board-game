extends Node2D

const HEX_SIZE := 18.0

var _board: HexBoard = null
var _cities: Array = []


func set_board_state(board: HexBoard, cities: Array) -> void:
	_board = board
	_cities = cities
	queue_redraw()


func _draw() -> void:
	if _board == null:
		return

	for coord in _board.get_all_coords_sorted():
		_draw_hex(_axial_to_pixel(coord), Color(0.25, 0.45, 0.25, 0.35))

	for city_data in _cities:
		var vertex_key: String = city_data.get("vertex_key", "")
		var center := _vertex_key_to_pixel(vertex_key)
		var color := Color.CORAL if city_data.get("player_id", 0) == 0 else Color.SKY_BLUE
		draw_circle(center, 6.0, color)


func _axial_to_pixel(coord: HexCoord) -> Vector2:
	var x := HEX_SIZE * sqrt(3.0) * (coord.q + coord.r / 2.0)
	var y := HEX_SIZE * 1.5 * coord.r
	return Vector2(x, y)


func _vertex_key_to_pixel(vertex_key: String) -> Vector2:
	for vertex in _board.get_all_vertices_sorted():
		if vertex.to_key() == vertex_key:
			var hexes := _board.get_hexes_for_vertex(vertex)
			if hexes.is_empty():
				return Vector2.ZERO
			var sum := Vector2.ZERO
			for hex in hexes:
				sum += _axial_to_pixel(hex)
			return sum / float(hexes.size())
	return Vector2.ZERO


func _draw_hex(center: Vector2, fill: Color) -> void:
	var points: PackedVector2Array = []
	for i in range(6):
		var angle := deg_to_rad(60.0 * i - 30.0)
		points.append(center + Vector2(cos(angle), sin(angle)) * HEX_SIZE)
	draw_colored_polygon(points, fill)
