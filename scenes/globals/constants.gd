extends Node

enum SCREENS {
	NONE,
	CREDITS,
	LEVEL,
	MENU,
	NEW_GAME,
	PATRONS,
	SETTINGS,
}

const SCREENS_PATHS := {
	SCREENS.CREDITS: "res://scenes/screens/credits.tscn",
	SCREENS.LEVEL: "res://scenes/screens/level.tscn",
	SCREENS.MENU: "res://scenes/screens/menu.tscn",
	SCREENS.NEW_GAME: "res://scenes/screens/new-game.tscn",
	SCREENS.PATRONS: "res://scenes/screens/patrons.tscn",
	SCREENS.SETTINGS: "res://scenes/screens/settings.tscn",
}

enum SOUNDS {
	NONE,
	BUTTON,
}

const SOUNDS_PATHS := {
	SOUNDS.BUTTON: ""
}

enum LEVELS {
	NONE,
	DINER_BLOCK,
}

const LEVELS_PATHS := {
	LEVELS.DINER_BLOCK: "res://scenes/levels/diner-block.tscn",
}

enum FIXTURES {
	NONE,
	POWER,
	WATER,
}

const FIXTURES_COLORS := {
	FIXTURES.POWER: [0.980, 0.690, 0.019],
	FIXTURES.WATER: [0.133, 0.545, 0.901],
}

const SAVE_FILE_PATH := "user://sitch.save"
const SAVE_FILE_KEY := "Psv88zNNissCwWcQng@KBDQm"