/// @Project by Kucia Guillaume* ///

if (TAG == undefined)
	return;

if (!FIRST_PASS && !FADE_IN) {image_alpha = 2; FIRST_PASS = true; } 

// FADE_IN

if (FADE_IN && image_alpha < 1)
	image_alpha += FADE_POWER * delta_time;
else
	FADE_IN = false;

if (CLOSE && string_count("SETTINGS", WINDOW_TAG)) {
	// DESTROY SETTING
	DestroySSystem(id);
	DestroySSystemDisplay(id);
	DestroySSystemSound(id);
	DestroySSystemPersonalize(id);
	DestroySSystemStorage(id);
	DestroySSystemAbout(id);
	
	DestroySNetwork(id);
	
	DestroySAccount(id);
	
	DestroySUpdate(id);

	if (ICON != undefined) {
		DestroyText(ICON.TEXT_CONNECT.TAG);
		DestroyObject(ICON.TAG);
		ICON = undefined;
	}
	if (FIND_SETTING != undefined)
		DestroyTextButton(FIND_SETTING.TAG);
	for (var i = 0; all_settings[i] != undefined; i++)
		DestroyEmptyButton(all_settings[i].TAG);
	if (SETTING_TITLE != undefined)
		DestroyText(SETTING_TITLE.TAG);
	DestroyObject(OBJECT_SELECT.TAG);
	DestroyObject(TAG);
	return;
}

if ((WINDOW != undefined && instance_exists(WINDOW)) && !CLOSE && string_count("SETTINGS", WINDOW.TAG) ) {
	
	if (CREATE) {

		// ICON POSITION
		if (ICON != undefined) {
			ICON.x = x - 332.5; ICON.y = y + 70;
			ICON.TEXT_CONNECT.x = ICON.x + 60; ICON.TEXT_CONNECT.y = ICON.y;
			ICON.image_alpha = image_alpha;
			ICON.TEXT_CONNECT.image_alpha = image_alpha;
			ICON.ON = WINDOW.ON;
		}
		
		//FIND SETTING
		if (FIND_SETTING != undefined) {
			FIND_SETTING.x = x - 247;FIND_SETTING.y = y + 150;
			FIND_SETTING.image_alpha = image_alpha;
			FIND_SETTING.ON = WINDOW.ON;
			if (!WINDOW.ON) {
				FIND_SETTING.write.ON_WRITE = false;
				FIND_SETTING.image_index = 0;
			}
		}
		
		// OBJECT SELECT
		if (OBJECT_SELECT != undefined) {
			var target = OBJECT_SELECT_INDEX.OBJECT_LINKED.y - 1;
			if (OBJECT_SELECT.y - target < 1 && OBJECT_SELECT.y - target > -1)
				OBJECT_SELECT_RUN = false;
			if (OBJECT_SELECT.y > target) {
				var distance = OBJECT_SELECT.y - target;
				OBJECT_SELECT.y -= (0.00001 * delta_time) * distance;
			}
			if (OBJECT_SELECT.y < target) {
				var distance = target - OBJECT_SELECT.y;
				OBJECT_SELECT.y += (0.00001 * delta_time) * distance;
			}
			if (!OBJECT_SELECT_RUN)
				OBJECT_SELECT.y = target;
			OBJECT_SELECT.x = OBJECT_SELECT_INDEX.x;
			OBJECT_SELECT.ON = WINDOW.ON;
		}
		
		// SETTING_TITLE
		if (SETTING_TITLE != undefined) {
			SETTING_TITLE.x = x + SETTING_TITLE_FX;
			SETTING_TITLE.y = y + 30;
			SETTING_TITLE.image_alpha = image_alpha;
		}
		
		// IMAGE ALPHA FOR PAGES
		for (var i = 0; SACCOUNT_OBJECT[i] != undefined; i++)
			SACCOUNT_OBJECT[i][3] = image_alpha;

		for (var i = 0; SSYSTEM_OBJECT[i] != undefined; i++)
			SSYSTEM_OBJECT[i][3] = image_alpha;

		for (var i = 0; SSSYSTEM_DISPLAY_OBJECT[i] != undefined; i++)
			SSSYSTEM_DISPLAY_OBJECT[i][3] = image_alpha;
		
		for (var i = 0; SSSYSTEM_SOUND_OBJECT[i] != undefined; i++)
			SSSYSTEM_SOUND_OBJECT[i][3] = image_alpha;

		for (var i = 0; SSSYSTEM_PERSONALIZE_OBJECT[i] != undefined; i++)
			SSSYSTEM_PERSONALIZE_OBJECT[i][3] = image_alpha;

		for (var i = 0; SSSYSTEM_STORAGE_OBJECT[i] != undefined; i++)
			SSSYSTEM_STORAGE_OBJECT[i][3] = image_alpha;
			
		for (var i = 0; SSSYSTEM_ABOUT_OBJECT[i] != undefined; i++)
			SSSYSTEM_ABOUT_OBJECT[i][3] = image_alpha;

		for (var i = 0; SNETWORK_OBJECT[i] != undefined; i++)
			SNETWORK_OBJECT[i][3] = image_alpha;
			
		for (var i = 0; SUPDATE_OBJECT[i] != undefined; i++) {
			SUPDATE_OBJECT[i][3] = image_alpha;
			if (SUPDATE_OBJECT[i][0].object_index == OJustButtonSettings)
				SUPDATE_OBJECT[i][0].ALPHA = image_alpha;
		}
		
		
		// UPDATE IN SETTING
		UpdateSSystem(id);
		UpdateSystemDisplay(id);
		UpdateSystemSound(id);
		UpdateSystemPersonalize(id);
		UpdateSystemStorage(id);
		UpdateSystemAbout(id);
		
		UpdateSNetwork(id);
		
		UpdateSAccount(id);
		
		UpdateSUpdate(id);
		
		// ALL_SETTING
		for (var i = 0; all_settings[i] != undefined; i++)
			all_settings[i].ON = WINDOW.ON;
		ON = false;
	}
	if (!CREATE) {
		
		// CREATE ICON
		if (global.USER[6][0] == 0)
			ICON = CreateObjectSprite(x - 332.5, y + 70, WINDOW.LAYERS[0], Shomme, OJustGUI, "IMAGE", "SETTINGS_USER_ICON_" + TAG , [["INDEX_IMAGE", global.USER[6][1]], ["SLIDE", 0.0001], ["FADE_IN", 0.000005], undefined]);
		else
			ICON = CreateObjectSprite(x - 332.5, y + 70, WINDOW.LAYERS[0], Sfemme, OJustGUI, "IMAGE", "SETTINGS_USER_ICON_" + TAG, [["INDEX_IMAGE", global.USER[6][1]], ["SLIDE", 0.0001], ["FADE_IN", 0.000005], undefined]);
		ICON.image_xscale = 0.7;
		ICON.image_yscale = 0.7;
		ICON.TEXT_CONNECT = AddText(ICON.x + 60, ICON.y, global.USER[1] + "\n" + AutoLanguage("Local Account"), Segoe10, c_black, WINDOW.LAYERS[1], "SETTINGS_USER_NAME_" + TAG, [["BACK", 5], undefined]);
		WINDOW.list_objects = addtolist(ICON, WINDOW.list_objects);
		
		

		// CREATE SETTING
		var system = CreateSetting( AutoLanguage("System"), S_Settings_System, WINDOW.LAYERS[0], WINDOW.LAYERS[1], TAG + "SYSTEM", id); system.SETTING_SELECT = true;
		OBJECT_SELECT_INDEX = system;
		OBJECT_SELECT = CreateObjectSprite(system.x + 125, system.OBJECT_LINKED.y - 1, WINDOW.LAYERS[1], S_Settings_Select, OJustGUI, "IMAGE", "SETTING_SELECT" + TAG, [undefined]);
		CreateSetting(AutoLanguage("Network & internet"), S_Settings_Network, WINDOW.LAYERS[0], WINDOW.LAYERS[1], TAG + "NETWORK", id);
		CreateSetting(AutoLanguage("Account"), S_Settings_Account, WINDOW.LAYERS[0], WINDOW.LAYERS[1], TAG + "ACCOUNT", id);
		CreateSetting(AutoLanguage("Update"), S_Settings_Update, WINDOW.LAYERS[0], WINDOW.LAYERS[1], TAG + "UPDATE", id);
		CreateSetting(AutoLanguage("Power system"), S_Settings_Power, WINDOW.LAYERS[0], WINDOW.LAYERS[1], TAG + "POWER_SYSTEM", id);
		WINDOW.list_objects = addtolist(OBJECT_SELECT, WINDOW.list_objects);
		
		// SETTING TITLE
		SETTING_TITLE = AddText(x - 100, y + 30, AutoLanguage("SYSTEM"), Segoe15, c_black, WINDOW.LAYERS[0], TAG + "SETTING_TITLE", [undefined]);
		
		// CREATE SETTING
		CreateSSystem(id);
		
		CREATE = true;
	} else if (CREATE && (WINDOW.ON || WINDOW.REDUCING || !WINDOW.FADE_MOVEMENT)) {
		ON = true;
	}	
	return;
}