extends Node

signal update_exp(score)
signal update_money(money)

var current_score : float = 0
var current_money : float = 0

func add_score(score : float):
	current_score += score
	
	update_exp.emit(score)

func add_money(money : float):
	current_money += money
	
	update_money.emit(money)
