extends Node

var dia_open = false
var dia_closing = false

var dia_dic = {
	"NoBF": [["Elm",0,"That looks like the way to the grove though...",">"],["Elm",0,"My eyes feel weird from it's brightness.",">"],["Elm",0,"I wonder if there's something around here that'll help.","v"]],
	"Crate" : [["Elm",0,"Text",">"],["Elm",0,"Text 2","v"]],
	"Lever" : [["Elm",1,"Option",">","Opt1","opt2",1,2],["Elm",0,"Option1","v"],["Elm",0,"Option2","v"]],
	"Lake" : [["Elm",0,"This is a lake, I'm going to look into it.","v"]],
	"Blindfold" : [["Elm",2,"This looks good, should protect my eyes nicely.","v","Blindfold","HIDE"]],
	"Blindfold2" : [["Elm",0,"There's nothing there, trust.","v"]],
	"G_Ash": [["Elm",0,"Nothing here but ash...","v"]],
	"G_Bark": [["Elm",0,"Burnt bark- I know how painful that is...","v"]],
	"G_Closed": [["Elm",0,"More of these things? They look... uncanny.","v"]],
	"G_Cloth": [["Elm",0,"We would spent time together as a grove making clothes for travlers...","v"]],
	"G_Crown": [["Elm",0,"A burned flowercrown, I can only hope the saplings got out safely.","v"]],
	"G_Final": [["Elm",0,"It's... looking at me...",">"],["Elm",0,"...",">"],["Elm",0,"I can't keep doing this.","v"]],
	"Empty" : [["Elm",0,"Already searched it.","v"]]
}

var scripted_dia = {
	"D1Pile" : [["Elm",0,"Its a bit hard to see with this blindfold on.",">"],["Elm",0,"Though if I feel around I should be able to move the rubbish around to see whats underneath.","v"]],
	"D2Pile" : [["Elm",0,"Huh, it's a bit easier to see? I wouldn't have thought anything's changed...","v"]],
	"D3Pile" : [["Elm",0,"...",">"],["Elm",0,"Is it the flowers? Am I... seing through them?",">"],["Elm",0,"Weird.","v"]],
	"D4Pile" : [["Elm",0,"It's surprisingly clear, though I don't feel up to this...",">"],["Elm",0,"I'll at least see what's under here.","v"]],
	"test" : [["Elm",0,"Well this is weird.",">"],["Elm",4,"There's going to be a new image.",">","Temp_Cutscene2"],["Elm",0,"Cool new image!","v"]],
	"Lake" : [["Elm",0,"My reflection? Why... why are those flowers staring back at me?","v"]],
	"D1End" : [["Elm",0,"Nothing... just piles of ash and remains.",">"],["Elm",0,"For seemingly nothing, I feel quite tired.",">"],["Elm",4,"I can continue searching later, a quick nap should be fine...",">","Temp_Cutscene2"],["",0,"...","v"]],
	"D2End" : [["Elm",0,"I should stop, my eyes are starting to hurt.",">"],["Elm",4,"At least things were'nt as dark as last time,, but its still so blurry.",">","Temp_Cutscene2"],["Elm",0,"I guess I'll keep searching later...","v"]],
	"D3End" : [["Elm",0,"There's so many of those flowers.",">"],["Elm",4,"They're all budding like the ones by my head...",">","Temp_Cutscene2"],["Elm",4,"No matter how I pull it, they seem to be attached to me...",">","Temp_Cutscene1"],["Elm",4,"Considering their growth, I should probably attempt to remove them.",">","Temp_Cutscene2"],["Elm",0,"Though- *yawn* maybe later I'm exhaused again...","v"]],
	"D4End" : [["Elm",0,"I don't think there's anything left for me to find. Unless I want to discover more of these petles staring at me.",">"],["Elm",4,"...",">","Temp_Cutscene2"],["Elm",4,"What can I do... I don't feel as tired anymore but I do feel off.",">","Temp_Cutscene1"],
	["Elm",4,"...",">","Temp_Cutscene2"],["Elm",4,"...",">","Temp_Cutscene1"],["Elm", 4,"Urgh! That's no use...",">","Temp_Cutscene2"],
	["",4,"Elm?",">","Temp_Cutscene1"],["Lavender",4,"What... what happened to you?","v","Temp_Cutscene2"]],
	"D1Grove" : [["Elm",0,"No...",">"],["Elm",0,"The Grove it's...",">"],["Elm",4,"Empty...",">","Temp_Cutscene2"],["Elm",0,"...",">"],["Elm",4,"Piles of ash? Maybe...",">","Temp_Cutscene1"],["Elm",0,"I should search around, maybe I'll find things in the ash piles.","v"]],
	"Start" : [["",0,"...",">"],["",4,"...?",">","Temp_Cutscene2"],["Elm",0,"What... where am I?",">"],["Elm",4,"Why is everyhing so blurry?",">","Temp_Cutscene1"],["Elm",4,"WHAT IS THAT?!",">","Temp_Cutscene2"],["Elm",0,"Get it off get it off get it off get it off get it-",">"],
	["Elm",4,"It's not budging...",">","Temp_Cutscene1"],["Elm",4,"The grove! Oh no I've got to make sure everyone's okay.","v","Temp_Cutscene2"]]
	
}

var pile_dic = {
	"pile" : [["Elm",1,"Should I search this pile?",">","Yes","No"]],
	
}
