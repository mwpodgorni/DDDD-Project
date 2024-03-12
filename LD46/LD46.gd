extends Node2D


var gameData=null;
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

	else:
		print("Failed to open file for reading.")
		
func saveToJson():
	if gameData!=null:
		currentGame["timestamp"] = get_timestamp()
		gameData.append(currentGame)  
	 
		var file = File.new()
		if file.open(g.projectPath, File.WRITE) != OK:
			print("Failed to open file for writing.")
			return
	 
		var jsonStr = JSON.print(gameData)
	 
		file.store_line(jsonStr)
		file.close()
		clearCurrentGame()
		print("Game data saved successfully!")
	else:
		print("couldnt save data")
		
func get_timestamp():
	var unix_timestamp = Time.get_unix_time_from_system()
	return unix_timestamp
