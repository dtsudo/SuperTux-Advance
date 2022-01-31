::meContribLevels <- [

]

::selectContrib <- function(){
	meContribLevels = []
	if(fileExists("contrib")){
		local contrib = lsdir("contrib")
		foreach(item in contrib){
			if(item != "." && item != ".." && isdir("contrib/"+item) && fileExists("contrib/"+item+"/info.json")){
				local data = jsonRead(fileRead("contrib/"+item+"/info.json"))
				meContribLevels.push(
					{
						contribFolder = item
						contribName = data["name"]
						contribWorldmap = data["worldmap"]
						name = function() { return contribName }
						func = function() {
							game=clone(gameDefault)
							game.completed.clear()
							game.allcoins.clear()
							game.allenemies.clear()
							game.allsecrets.clear()
							game.besttime.clear()
							game.file = contribFolder
							game.path = "contrib/" + contribFolder + "/"
							game.world = contribWorldmap
							gvDoIGT = false
							if(fileExists("contrib/" + contribFolder + "/" + config.lang + ".json")) {
								gvLangObj = mergeTable(gvLangObj, jsonRead(fileRead("contrib/" + contribFolder + "/" + config.lang + ".json")))
								print("Found text.json")
							}
							else if(fileExists("contrib/" + contribFolder + "/text.json")) {
								gvLangObj = mergeTable(gvLangObj, jsonRead(fileRead("contrib/" + contribFolder + "/text.json")))
								print("Found text.json")
							}
							if(fileExists("save/" + contribFolder + ".json")) loadGame(contribFolder)
							else startOverworld("contrib/" + contribFolder + "/" + contribWorldmap)
						}
					}
				)
			}
		}
	}

	if(meContribLevels.len() == 0){
		meContribLevels.push(
				{
					name = function() { return gvLangObj["contrib-menu"]["empty"] }
					func = function() { }
				}
			)
	}
	else //Sort contrib levels
	meContribLevels.sort(function(a, b) {
		if(a.name() > b.name()) return 1
		if(a.name() < b.name()) return -1
		return 0
	})

	meContribLevels.push(
		{
			name = function() { return "Back" }
			func = function(){
				menu = meMain
			}
		}
	)

	menu = meContribLevels
}
