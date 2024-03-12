extends Node2D


var gameData;
var currentGame = {
		 "timestamp": null,
		 "droppedSwords": 0,
		 "dodgedSwords": 0,
		 "wonWaves": 0,
		 "gameOverReason": null,
		 "wonGame": false,
		 "firstDeflectedSwordWave": 0
	  }

func _ready():
	loadFromJson()
	connect("game_over", self, "saveToJson")

func clearCurrentGame():
	currentGame = {
		 "timestamp": null,
		 "droppedSwords": 0,
		 "dodgedSwords": 0,
		 "wonWaves": 0,
		 "gameOverReason": null,
		 "wonGame": false,
		 "firstDeflectedSwordWave": 0
	  }
	
func getCurrentGameField(key):
	return currentGame[key]
	
func updateCurrentGameField(key, value):
	currentGame[key]=value
	
func increaseGameFieldValue(key):
	currentGame[key]+=1
	
func loadFromJson():
	var file = File.new()
	if file.open(g.projectPath, File.READ) == OK:
		var jsonStr = file.get_as_text()
		file.close()
		
		var jsonData = JSON.parse(jsonStr).result
		if jsonData == null:
			print("Error parsing JSON data:")
			return  
			
		gameData=jsonData
#			for play in jsonData["plays"]:
#				print("\tTimestamp:", play["timestamp"])
#				print("\tDropped Swords:", play["droppedSwords"])
#				print("\tDodged Swords:", play["dodgedSwords"])
#				print("\tWon Waves:", play["wonWaves"])
#				print("\tGame Over Reason:", play["gameOverReason"])
#				print("\tWon Game:", play["wonGame"])
#				print("\tFirst Deflected Sword Wave:", play["firstDeflectedSwordWave"])
#				print("----------")
	else:
		print("Failed to open file for reading.")
		
func saveToJson():
	print("saveToJson")
	currentGame["timestamp"] = get_timestamp()
	gameData.append(currentGame)  
 
	var file = File.new()
	if file.open(g.projectPath, File.WRITE) != OK:
		print("Failed to open file for writing.")
		return
 
	var jsonStr = JSON.print(gameData)
 
	file.store_line(jsonStr)
	file.close()
	print("Game data saved successfully!")
		
func get_timestamp():
	var unix_timestamp = Time.get_unix_time_from_system()
	return unix_timestamp