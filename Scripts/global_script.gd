extends Node

var dialogue_open = false 
var can_move = true

var dialogue_dic = {
	"Crate": [" Ann","Temp_Icon0", "0","This is a crate :D","0"],
	"Lever": [" Jesper","Temp_Icon1","0","This is a lever", "don't pull it","ya can't anyway.","0"],
	"Question": [" Jesper","Temp_Icon1","3",["This is a question, answer yes or no.","YES","NO"],"You answered yes!","You answered no.","0"]
}
