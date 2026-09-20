extends Node

var dia_open = false
var dia_closing = false
var scripted = false

var dia_dic = {
	"NoBF": [["Elm",0,"The forest over there looks bright, it's giving me a headache even from here.",">"],["Elm",0,"I wonder if there's something around here that'll help.","v"]],
	"Crate" : [["Elm",0,"Text",">"],["Elm",0,"Text 2","v"]],
	"Lever" : [["Elm",1,"Option",">","Opt1","opt2",1,2],["Elm",0,"Option1","v"],["Elm",0,"Option2","v"]],
	"Lake" : [["Elm",0,"This is a lake, I'm going to look into it.","v"]],
	"Blindfold" : [["Elm",2,"This looks good, should protect my eyes nicely.","v","Blindfold","Blindfold2"]],
	"Blindfold2" : [["Elm",0,"There's nothing there, trust.","v"]],
	"G_Ash": [["Elm",0,"Nothing here but ash...","v"]],
	"G_Bark": [["Elm",0,"Burnt bark- I know how painful that is...","v"]],
	"G_Closed": [["Elm",0,"More of these things? They look... uncanny.","v"]],
	"G_Cloth": [["Elm",0,"We would spent time together as a grove making clothes for travlers...","v"]],
	"G_Crown": [["Elm",0,"A burned flowercrown, I can only hope the saplings got out safely.","v"]],
	"G_Final": [["Elm",0,"It's... looking at me...",">"],["Elm",0,"...",">"],["Elm",0,"I can't keep doing this.","v"]]
}

var scripted_dia = {
	"D1Pile" : [["Elm",0,"Its a bit hard to see with this blindfold on.",">"],["Elm",0,"Though if I feel around I should be able to move the rubbish around to see whats underneath.","v"]],
	"D2Pile" : [["Elm",0,"Huh, it's a bit easier to see? I wouldn't have thought anything's changed...","v"]],
	"D3Pile" : [["Elm",0,"...",">"],["Elm",0,"Is it the flowers? Am I... seing through them?",">"],["Elm",0,"Weird.","v"]],
	"D4Pile" : [["Elm",0,"It's surprisingly clear, though I don't feel up to this...",">"],["Elm",0,"I'll at least see what's under here.","v"]],
	"test" : [["Elm",0,"Well this is weird.",">"],["Elm",4,"There's going to be a new image.",">","Temp_Cutscene2"],["Elm",0,"Cool new image!","v"]],
	"Lake" : [["Elm",0,"My reflection? Why... why are those flowers staring back at me?","v"]]
}

var pile_dic = {
	"pile" : [["Elm",1,"Should I search this pile?",">","Yes","No"]],
	
}
