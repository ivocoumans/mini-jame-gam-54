extends Node

var is_future: bool = false
var money: int = 0
var saplings: int = 1
var bananas: int = 0
var plots: int = 1
var max_plots: int = 9

var _sapling_costs: Array[int] = [3, 4, 5, 6, 7, 8, 9, 10, 10]
var _plot_costs: Array[int] = [15, 30, 50, 75, 165, 185, 350, 400, 400]
var _banana_yields: Array[int] = [3, 3, 3, 3, 4, 4, 5, 5, 5]
var _banana_values: Array[int] = [3, 3, 3, 3, 3, 3, 3, 3, 3]


func get_sapling_cost() -> int:
	return _sapling_costs[plots - 1]


func get_plot_cost() -> int:
	return _plot_costs[plots - 1]


func get_banana_yield() -> int:
	return _banana_yields[plots - 1]


func get_banana_value() -> int:
	return _banana_values[plots - 1]
