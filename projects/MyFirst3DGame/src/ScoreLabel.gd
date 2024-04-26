extends Label

var score = 0
var multiplier = 1

func _on_mob_squashed():
	score += 1 * multiplier
	multiplier += 1
	print_score()

func _on_player_landed():
	multiplier = 1
	print_score()

func print_score():
	text = "Score: %s" % score
	text += " - Multiplier: %s" % multiplier
