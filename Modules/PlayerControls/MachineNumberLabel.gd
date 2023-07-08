extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var armors := "Armors: " + str(GlobalInfo.baseMachineNumber) + "/" + str(GlobalInfo.baseMachineLimit)
	var grabbers := "Grabbers: " + str(GlobalInfo.grabberMachineNumber) + "/" + str(GlobalInfo.grabberMachineLimit)
	var treads := "Treads: " + str(GlobalInfo.treadMachineNumber) + "/" + str(GlobalInfo.treadMachineLimit)
	text = armors + "\n" + grabbers + "\n" + treads
	GlobalInfo.base_machine_num_changed.connect(update_label)
	GlobalInfo.grabber_machine_num_changed.connect(update_label)
	GlobalInfo.tread_machine_num_changed.connect(update_label)

func update_label() -> void:
	if GlobalInfo.baseMachineNumber < 0:
		GlobalInfo.baseMachineNumber = 0
	if GlobalInfo.grabberMachineNumber < 0:
		GlobalInfo.grabberMachineNumber = 0
	if GlobalInfo.treadMachineNumber < 0:
		GlobalInfo.treadMachineNumber = 0
	var armors := "Armors: " + str(GlobalInfo.baseMachineNumber) + "/" + str(GlobalInfo.baseMachineLimit)
	var grabbers := "Grabbers: " + str(GlobalInfo.grabberMachineNumber) + "/" + str(GlobalInfo.grabberMachineLimit)
	var treads := "Treads: " + str(GlobalInfo.treadMachineNumber) + "/" + str(GlobalInfo.treadMachineLimit)
	text = armors + "\n" + grabbers + "\n" + treads
