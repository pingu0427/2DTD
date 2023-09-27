extends PopupMenu

func _ready():
	$VBoxContainer/HBoxContainer/TowerUpgradeButton.pressed.connect(self._on_TowerUpgradeButton_pressed)
	$VBoxContainer/HBoxContainer2/NewTowerButton.pressed.connect(self._on_NewTowerButton_pressed)
	$VBoxContainer/HBoxContainer3/HeroUpgradeButton.pressed.connect(self._on_HeroUpgradeButton_pressed)
func _on_TowerUpgradeButton_pressed():
	# Handle the tower upgrade option...
	pass

func _on_NewTowerButton_pressed():
	# Handle the new tower option...
	pass

func _on_HeroUpgradeButton_pressed():
	# Handle the hero upgrade option...
	pass
