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

enum PEOPLE {
	NONE,
	RESIDENT,
	DELI_WORKER,
	DELI_CUSTOMER,
}

const PEOPLE_MIN_IDLE_TIME := 5.0
const PEOPLE_MAX_IDLE_TIME := 10.0
const PEOPLE_MIN_WAIT_TIME := 4.0
const PEOPLE_MAX_WAIT_TIME := 8.0
const PEOPLE_WAIT_PENALTY := 5
const PEOPLE_MOVE_SPEED := 100

const TICK_SECONDS := 5.0
const TICK_MINUTES_INCREASE := 30

const STARTING_POWER := 100
const STARTING_WATER := 100
const STARTING_MONEY := 250
const STARTING_HOURS := 12
const STARTING_MINUTES := 0
const STARTING_DAYS := 1

const REFILL_COST_POWER := 50
const REFILL_COST_WATER := 50

const SAVE_FILE_PATH := "user://sitch.save"
const SAVE_FILE_KEY := "Psv88zNNissCwWcQng@KBDQm"
