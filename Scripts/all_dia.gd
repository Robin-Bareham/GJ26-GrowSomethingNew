extends Node

var dia_open = false
var dia_closing = false

var lake_interacted = false

var randomPileMax = 2

var dia_dic = {
	"NoBF": [["Elm",0,"That looks like the way to the grove though...",">"],["Elm",0,"My eyes feel weird from it's brightness.",">"],["Elm",0,"I wonder if there's something around here that'll help.","v"]],
	"Blindfold" : [["Elm",2,"This looks good, should protect my eyes nicely.","v","Blindfold","HIDE"]],
	"G_Ash": [["Elm",0,"Nothing here but ash...","v"],["Elm",0,"Ash...","v"],["Elm",0,"...","v"]],
	"G_Bark": [["Elm",0,"Burnt bark- I know how painful that is...","v"],["Elm",0,"The bark's been ripped off before it could heal.","v"],["Elm",0,"...","v"]],
	"G_Closed": [["Elm",0,"More of these things? They look... uncanny.","v"],["Elm",0,"They're closed up, don't they need the light?","v"],["Elm",0,"...","v"]],
	"G_Cloth": [["Elm",0,"We would spent time together as a grove making clothes for travlers...","v"],["Elm",0,"The cloth look ragged, I hope they were fine.","v"],["Elm",0,"...","v"]],
	"G_Crown": [["Elm",0,"A burned flowercrown, I can only hope the saplings got out safely.","v"],["Elm",0,"More flowercrowns...","v"],["Elm",0,"...","v"]],
	"G_Final": [["Elm",0,"It's... looking at me...",">"],["Elm",0,"...",">"],["Elm",0,"I can't keep doing this.","v"],["Elm",0,"2","v"]]
}

var scripted_dia = {
	"D1Pile" : [["Elm",0,"Its a bit hard to see with this blindfold on.",">"],["Elm",0,"Though if I feel around I should be able to move the rubbish around to see whats underneath.","v"]],
	"D2Pile" : [["Elm",0,"Huh, it's a bit easier to see? I wouldn't have thought anything's changed...","v"]],
	"D3Pile" : [["Elm",0,"I'd have thought my vision would be darker, I am still wearing the blindfold.",">"],["Elm",0,"Maybe it's the weird flowers? How I don't know but they're the only difference...",">"],["Elm",0,"Weird.","v"]],
	"D4Pile" : [["Elm",0,"I can see most of the grove now, clearer than ever...",">"],["Elm",0,"I... I don't think I'll find anything but, one more search can't hurt.","v"]],
	"D1End" : [["Elm",0,"It's too dark to see anymore... but, I don't think there was anything important.",">"],["Elm",0,"For good and bad.",">"],["Elm",4,"...",">","D1End02"],["Elm",0,"I feel exhaused.",">"],
	["Elm",4,"I might just lie here for a bit... and carry on later...",">","D1End03"],["",0,"",">"],["",4,"","v","D1End04"]],
	"D2End" : [["Elm",0,"An empty search, though this caught my eye on the way back.",">"],["Elm",0,"I swear this wasn't there yesterday... is this... the hell?",">"],
	["Elm",4,"...",">","D2End02"],["",5,"",">","SFX_Crumple"],["Elm",4,"I wish I could've searched more.",">","D2End03"],["Elm",0,"Damn new pains, maybe some rest will help...",">"],["",0,"",">"],["",4,"","v","D2End04"]],
	"D3End" : [["Elm",0,"These buds are everywhere! How could so many of them appeared?",">"],["Elm",0,"I was able to pull one out of the ash, there was barely any resistance.",">"],["Elm",4,"I wonder...",">","D3End02"],["",4,"",">","D3End03"],["",4,"",">","D3End04"],
	["",4,"",">","D3End05"],["",4,"",">","D3End06"],["Elm",4,"No use, it's like glue...",">","D3End07"],["Elm",4,"...",">","D3End08"],["Elm",0,"Who knows, it could be a good thing, from what I can tell it's helping me see?",">"],["",0,"",">"],["Elm",4,"Who knows...","v","D3End09"]],
	"D4End" : [["Elm",0,"",">"],["",4,"",">","D4End02"],["",4,"",">","D4End03"],["Elm",0,"Alright. I'm done.",">"],["Elm",0,"I doubt there's anything left here.",">"],
	["Elm",4,"It does help that I can see better now.",">","D4End04"],["Elm",4,"I can only hope there were some survivors.",">","D4End05"],
	["Elm",0,"Maybe I'll find them someday...",">"],["",4,"",">","D4End06"],["Elm",0,"Is this going to be perminant?",">"],["Elm",0,"Although most of the aches and pains are gone, things just don't...",">"],["Elm",0,"They just don't feel that same...",">"],
	["Elm",4,"I would blame these pettles if I knew what they were.",">","D4End07"],["Elm",0,"I guess I could-",">"],["",4,"Elm?",">","D4End08"],["Lavender",4,"What happened to you?","v","D4End09"]],
	"D1Grove" : [["Elm",0,"...",">"],["Elm",0,"",">"],["Elm",0,"It can't be...",">"],["Elm",4,"Did it... how could it all be gone?",">","Grove02"],["Elm",0,"",">"],["Elm",4,"What's this? There's stuff under the clumps of ash.",">","Grove03"],["Elm",0,"I should search them, maybe I'll find...",">"],["Elm",0,"... Hopefully something good.","v"]],
	"Start" : [["",0,"",">"],["",4,"...?",">","Start02"],["Elm",0,"What... where am I?",">"],["Elm",4,"Why is everything so bright?",">","Start03"],["Elm",0,"...",">"],["Elm",4,"WHAT IS THAT?!",">","Start04"],["Elm",0,"Get it off get it off get it off get it off get it-",">"],
	["Elm",4,"It's stuck to my bark!",">","Start06"],["Elm",0,"...",">"],["Elm",4,"The grove!",">","Start05"],["Elm",0,"Oh no I need to see if everyone's okay.","v",]],
	"D1Lake" : [["Elm",0,"Those scars... I'm sure I just got burned... how long have I been out for?",">"], ["Elm",0,"...",">"],["Elm",2,"Weird...","v","N/A","LAKE"]],
	"D1Lake2" : [["Elm",2,"Ah, that's a bit easier to look through. The water's glare doesn't hurt as much.","v","N/A","LAKE"]],
	"D2Lake" : [["Elm",0,"It's... grown? Are those vines?",">"],["Elm",0,"They feel like vines...",">"],["Elm",2,"Now it's staring at me through the reflection...","v","N/A","LAKE"]],
	"D3Lake" : [["Elm",0,"Are these horns? Ow-",">"],["Elm",0,"They're thorny like those roots.",">"],["Elm",2,"Urgh- I'm just going to stop, this is giving me a headache.","v","N/A","LAKE"]],
	"D4Lake" : [["Elm",2,"...","v","N/A","LAKE"]],
	"LakeSil" : [["Elm",0,"","v"]]
}

var pile_dic = {
	"pile" : [["Elm",1,"Should I search this pile?",">","Yes","No"]],
	
}
