extends Control

func _ready():
	for i in range(1, 11):
		var button = $ScrollContainer/GridContainer.get_node("Map" + str(i) + "Button")
		button.pressed.connect(self._on_MapButton_pressed([i]))

func _on_MapButton_pressed(map_number):
	print("Map " + str(map_number) + " selected")
	# You can replace this with code to load the selected map
