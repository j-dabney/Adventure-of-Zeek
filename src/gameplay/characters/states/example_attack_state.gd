class_name ExampleAttackState
extends State
## This is only meant as a template for character state-machines.

# const IDLE: String = "IdleAttack"
# const PRIMARY: String = "PrimaryAttack"
# const SECONDARY: String = "SecondaryAttack"
# const UTILITY: String = "UtilityAttack"
# const SPECIAL: String = "SpecialAttack"

var character: Character
var character_controller: CharacterController

func _ready() -> void:
	character = owner as Character
	character_controller = character.input_controller as CharacterController
