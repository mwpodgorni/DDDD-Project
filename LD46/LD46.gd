extends Node2D


var gameData=null;
var currentGame = {
		 "version": 'B',
		 "timePassed":null,
		 "timestamp": null,
		 "droppedSwords": 0,
		 "dodgedSwords": 0,
		 "wonWaves": 0,
		 "gameOverReason": null,
		 "wonGame": false,
		 "firstDeflectedSwordWave": 0
	  }
var start_time;
var end_time;
func _ready():
	print("READY")
	loadFromJson()
	connect("game_over", self, "saveToJson")
	start_time = OS.get_unix_time()

func clearCurrentGame():
	currentGame = {
		 "version": 'B',
		 "timestamp": null,
		 "droppedSwords": 0,
		 "dodgedSwords": 0,
		 "wonWaves": 0,
		 "gameOverReason": null,
		 "wonGame": false,
		 "firstDeflectedSwordWave": 0
	  }
	start_time = OS.get_unix_time()
	
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
	print("SAVE TO JSON")
	if gameData!=null:
		end_time=OS.get_unix_time()
		var passed=end_time-start_time
		print("PASSED TIME",passed)
		currentGame["timePassed"]=passed
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


