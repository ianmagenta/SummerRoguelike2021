extends Actor
class_name Player

func take_turn(data: Dictionary):
	(data.game.player_controller as PlayerController).controlled_entity = self
