/// @Project by Kucia Guillaume* ///


// INIT LIKR_lIST
if (global.USER[9][0] == undefined) {
	for (var i = 0; i != 15; i++)
		global.USER[9][i] = 0;
}


// CREATE OBJECTS
CreateObjects(960, 540, "Cursor",  Ocursor, "CURSOR", "CURSOR", [undefined]);
CreateObjectSprite(0, 0, "Gp1", Suser_connect_background, OJustGUI, "IMAGE", "USER_BACKGROUND", [["FADE_IN", 0.0000005], undefined]);
AddText(960, 240, "16:01", Segoe75, c_white, "Gp2", "CURRENT_TIME", [["CENTERED"],["FADE_IN", 0.0000005], undefined]);
AddText(960, 320, "dimanche 22 mai", Arial15, c_white, "Gp2", "CURRENT_DATE", [["CENTERED"],["FADE_IN", 0.0000005], undefined]);
CreateButtonBox(1737.5, 56.75, Sphoto, OboxText, "Do you like the displayed image ?", "Gp2", "Gp3", Arial10, c_white, "PHOTO", [["CENTERED"], ["POSITIONS", 1737.5, 90], undefined]);
CreateObjectSprite(1866, 1041.15, "Gp2", Swifi, OJustGUI, "BUTTON-NO-HAND", "IMAGE_WIFI", [["INFO", "Wifi"], ["FADE_IN", 0.0000003], undefined]);


