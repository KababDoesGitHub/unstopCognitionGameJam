extends Node

@onready var players := {
	"1": {
		viewport = $SubViewportContainer/SubViewport,
		camera = $SubViewportContainer/SubViewport/Camera2D,
		player = $SubViewportContainer/SubViewport/Game/player
	},
	"2": {
		viewport = $SubViewportContainer2/SubViewport,
		camera = $SubViewportContainer2/SubViewport/Camera2D2,
		player = $SubViewportContainer/SubViewport/Game/player2
	}
}

func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)

func _process(_delta: float) -> void:
	pass
