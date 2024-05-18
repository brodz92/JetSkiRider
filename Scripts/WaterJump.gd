extends Node




func _on_area_2d_body_entered(body: Node2D) -> void:
	SignalBus.emit_signal("playerJumpSmall")
