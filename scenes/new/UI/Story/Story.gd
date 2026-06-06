extends Control

const text2 = "In an alternate reality, humans embarked on a bold experiment, creating a unique life form known as froggys to serve as their loyal workforce. However, what began as a simple task quickly spiraled into something far beyond human comprehension. These froggys evolved at an astonishing rate, their intelligence growing exponentially until they stood on the precipice of godhood. With their newfound wisdom, they decided to forge their own destiny and carved out a planet of their own, where they came to be known as the MadFroggys. As they shaped their world with unparalleled creativity, they remained a testament to the unpredictable marvels that can emerge when ambition and curiosity collide in the boundless reaches of alternate realities." 
const text1 = "The MadFroggy defense was valiant, but the Vyrothians were overwhelming in numbers and firepower. Despite their remarkable intelligence and ingenuity, the MadFroggys were pushed to the brink of extinction. As the war raged on, their cities crumbled, and their population dwindled.Captain Froggy, the most skilled and courageous warrior among the MadFroggys, emerged as the last hope for their survival. He had witnessed the fall of his comrades, and now he carried the weight of his people's destiny on his amphibian shoulders. With determination and unwavering resolve, he embarked on a perilous journey to rally whatever remnants of his species remained, hoping to turn the tide against the Vyrothian invaders.Armed with advanced technology and the unmatched creativity that had once defined his species, Captain Froggy ventured deep into enemy territory, striking back with guerrilla tactics and cunning strategies. He discovered ancient relics of his ancestors that contained untapped power, which he harnessed to empower himself and his loyal followers."

@onready var text = $hbox/ScrollContainer/Panel

func _ready():
	text.text = text1
	$AnimationPlayer.play("intro")

func _on_Story_pressed():
	text.text = text1
	$AnimationPlayer.play("intro")


func _on_Madfroggys_pressed():
	text.text = text2
	$AnimationPlayer.play("intro")


func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
