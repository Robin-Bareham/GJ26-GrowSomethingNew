extends Node

var dia_open = false
var dia_closing = false

var lake_interacted = false

var randomPileMax = 3

var dia_dic = {
	"NoBF": [["Elm",0,"That looks like the way to the grove though...",">"],["Elm",0,"My eyes feel weird from it's brightness.",">"],["Elm",0,"I wonder if there's something around here that'll help.","v"]],
	"Blindfold" : [["Elm",2,"This looks good, should protect my eyes nicely.","v","Blindfold","HIDE"]],
	"G_Ash": [["Elm",0,"Nothing here but ash...","v"],["Elm",0,"Ash...","v"],
	["Elm",0,"...","v"],["Elm",0,"It seems to disintegrate upon touch.","v"]],
	"G_Bark": [["Elm",0,"Burned bark? That looks painful.","v"],["Elm",0,"The bark's been ripped off before it could heal.","v"],
	["Elm",0,"...","v"],["Elm",0,"These remind me of my own burns.","v"]],
	"G_Closed": [["Elm",0,"More of these things? They look... uncanny.","v"],["Elm",0,"They're closed up, don't they need the light?","v"],
	["Elm",0,"...","v"],["Elm",0,"They've spread like a disease. How could they survive here?","v"]],
	"G_Cloth": [["Elm",0,"Torn cloth, the stitching is fused with the fabric.","v"],["Elm",0,"The cloth look ragged, I hope they're fine.","v"],
	["Elm",0,"...","v"],["Elm",0,"As a grove we would spend time making clothes for those who needed it...","v"]],
	"G_Crown": [["Elm",0,"A burned flowercrown, I can only hope the saplings got out safely.","v"],["Elm",0,"More flowercrowns...","v"],
	["Elm",0,"...","v"],["Elm",0,"Who would want to burn someone so young?","v"]],
	"G_Final": [["Elm",0,"...","v"]]
}

var scripted_dia = {
	"D1Pile" : [["Elm",0,"Its a bit hard to see with this blindfold on.",">"],["Elm",0,"Though if I feel around I should be able to move the rubbish around to see whats underneath.","v"]],
	"D2Pile" : [["Elm",0,"It's a bit easier to see? That shouldn't be right...","v"]],
	"D3Pile" : [["Elm",0,"I'd have thought my vision would be darker, I am still wearing the blindfold.",">"],["Elm",0,"Maybe it's the weird flowers? I wouldn't know how but they're the only difference...","v"]],
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
	["Elm",4,"I would blame these petals if I knew what they were.",">","D4End07"],["Elm",0,"I guess I could-",">"],["",4,"Elm?",">","D4End08"],["Lavender",4,"What happened to you?","v","D4End09"]],
	"D1Grove" : [["Elm",0,"...",">"],["Elm",0,"",">"],["Elm",0,"It can't be...",">"],["Elm",4,"Did it... how could it all be gone?",">","Grove02"],["Elm",0,"",">"],["Elm",4,"What's this? There's stuff under the clumps of ash.",">","Grove03"],["Elm",0,"I should search them, maybe I'll find...",">"],["Elm",0,"... Hopefully something good.","v"]],
	"Start" : [["",0,"",">"],["",4,"...?",">","Start02"],["Elm",0,"What... where am I?",">"],["Elm",4,"Why is everything so bright?",">","Start03"],["Elm",0,"...",">"],["Elm",4,"WHAT IS THAT?!",">","Start04"],["Elm",0,"Get it off get it off get it off get it off get it-",">"],
	["Elm",4,"It's stuck to my bark!",">","Start06"],["Elm",0,"...",">"],["Elm",4,"The grove!",">","Start05"],["Elm",0,"Oh no I need to see if everyone's okay.","v",]],
	"D1Lake" : [["Elm",0,"Those scars... I'm sure I just got burned... how long have I been out for?",">"], ["Elm",0,"...",">"],["Elm",2,"Weird...","v","N/A","LAKE"]],
	"D1Lake2" : [["Elm",2,"Ah, that's a bit easier to look through. The water's glare doesn't hurt as much.","v","N/A","LAKE"]],
	"D2Lake" : [["Elm",0,"It's... grown? Are those vines?",">"],["Elm",0,"They feel like vines...",">"],["Elm",2,"Now it's staring at me through the reflection...","v","N/A","LAKE"]],
	"D3Lake" : [["Elm",0,"Are these horns? Ow-",">"],["Elm",0,"They're thorny like those roots.",">"],["Elm",2,"Urgh- I'm just going to stop, this is giving me a headache.","v","N/A","LAKE"]],
	"D4Lake" : [["Elm",2,"...","v","N/A","LAKE"]],
	"LakeSil" : [["Elm",0,"","v"]],
	"BRCorner" : [["Elm",0,"The forest looks rather thick and dark over there. Best to stay away.","v"]],
	"BRCorner3" : [["Elm",0,"Its hard to see, but I don't think there's any of those weird buds over there.","v"]],
	"Tree" : [["Elm",0,"The foliage seems healthy here. I guess the river does help.","v"]],
	"Tree3": [["Elm",0,"There's these buds at the base, from a glance they look firmly planted but...",">"],["Elm",0,"They seem rather loose...","v"]]
}

var pile_dic = {
	"pile" : [["Elm",1,"Should I search this pile?",">","Yes","No"]],
	
}
