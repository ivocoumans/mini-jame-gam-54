extends Node

var is_future: bool = false
var money: int = 0
var saplings: int = 1
var bananas: int = 0
var plots: int = 1
var max_plots: int = 9

var _sapling_costs: Array[int] = [3, 3, 3, 3, 3, 3, 3, 3, 3]
var _plot_costs: Array[int] = [9, 20, 50, 70, 115, 140, 210, 235, 235]
var _banana_yields: Array[int] = [3, 3, 3, 3, 3, 3, 3, 3, 3]
var _banana_values: Array[int] = [3, 3, 3, 3, 3, 3, 3, 3, 3]
var _movement_speed: Array[float] = [175.0, 175.0, 180.0, 180.0, 185.0, 185.0, 195.0, 195.0, 200.0]


func get_sapling_cost() -> int:
	return _sapling_costs[plots - 1]


func get_plot_cost() -> int:
	return _plot_costs[plots - 1]


func get_banana_yield() -> int:
	return _banana_yields[plots - 1]


func get_banana_value() -> int:
	return _banana_values[plots - 1]


func get_movement_speed() -> float:
	return _movement_speed[plots - 1]
