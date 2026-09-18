extends Node

var dia_open = false
var dia_closing = false
var scripted = false

var dia_dic = {
	"NoBF": [["tempI",0,"The forest over there looks bright, it's giving me a headache even from here.",">"],["tempI",0,"I wonder if there's something around here that'll help.","v"]],
	"Crate" : [["tempI",0,"Text",">"],["tempI",0,"Text 2","v"]],
	"Lever" : [["tempI",1,"Option",">","Opt1","opt2",1,2],["tempI",0,"Option1","v"],["tempI",0,"Option2","v"]],
	"Lake" : [["tempI",0,"This is a lake, I'm going to look into it.","v"]],
	"Blindfold" : [["tempI",2,"This looks good, should protect my eyes nicely.","v","Blindfold","Blindfold2"]],
	"Blindfold2" : [["tempI",0,"There's nothing there, trust.","v"]]
}

var pile_dic = {
	"pile" : [["tempI",1,"Should I search this pile?",">","Yes","No"]]
}
