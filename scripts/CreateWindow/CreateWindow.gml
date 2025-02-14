

function CreateWindow(WINDOW_BK, WINDOW_BK_OBJECT, TAG, ICON, NAME, TOP_WINDOW) {
	static ID = 0;
	
	DestroyHome();
	if (ON_MAIN_SCENE.N_WINDOW >= ON_MAIN_SCENE.N_WINDOW_LIMITED) {
		CreateNotification(Ssystem_icon, AutoLanguage("Warning"), AutoLanguage("Too many windows have already been created"), "TOO_MANY_WINDOW");
		return;
	}
	ON_MAIN_SCENE.N_WINDOW += 1;	
	// LAYER
	OPTION = [["FADE_IN", 0.000005], undefined];
	for (var i = 0; global.layer_depth[i] != undefined; ) { i++; }
	var LAYER_1 = string(ID) + "LAYER" + string(global.last_layer_id - 1);
	layer_create(global.last_layer_id - 1, LAYER_1);
	var LAYER_2 = string(ID) + "LAYER" + string(global.last_layer_id - 2);
	layer_create(global.last_layer_id - 2, LAYER_2);
	var Gp0 = string(ID) + "GP0" + string(global.last_layer_id - 3);
	var Gp1 = string(ID) + "GP1" + string(global.last_layer_id - 4);
	var Gp2 = string(ID) + "GP2" + string(global.last_layer_id - 5);
	var Gp3 = string(ID) + "GP3" + string(global.last_layer_id - 6);
	var Gp4 = string(ID) + "GP4" + string(global.last_layer_id - 7);
	layer_create(global.last_layer_id - 3, Gp0);layer_create(global.last_layer_id - 4, Gp1);
	layer_create(global.last_layer_id - 5, Gp2);layer_create(global.last_layer_id - 6, Gp3);
	layer_create(global.last_layer_id - 7, Gp4);
	global.layer_depth[i] = ["LAYER" + string(ID), [LAYER_1, LAYER_2, Gp0, Gp1, Gp2, Gp3, Gp4, undefined]];
	global.layer_depth[i + 1] = undefined;
	global.last_layer_id -= 7;

	var window = CreateObjectSprite(960, 540 - (sprite_get_height(WINDOW_BK)/2) + 30, LAYER_1, TOP_WINDOW, Owindow, "TOP_WINDOW", TAG + string(ID), OPTION);
	window.WINDOW_BK = CreateObjectSprite(960 + 3, window.y + (window.sprite_height/2) - 6, LAYER_1, WINDOW_BK, WINDOW_BK_OBJECT, "WINDOW_BK", TAG + "_BK" + string(ID), OPTION);
	window.CLOSE = CreateObjectSprite(window.bbox_left + 17.5 + 10, window.y + 3, LAYER_2 , Swindow_close, OJustGUI, "BUTTON-NO-HAND", TAG + "CLOSE" + string(ID), OPTION);
	window.REDUCE = CreateObjectSprite(window.bbox_left + 42.5 + 10, window.y + 3, LAYER_2 , Swindow_reduce, OJustGUI, "BUTTON-NO-HAND", TAG + "CLOSE" + string(ID), OPTION);
	window.WINDOW_TOP_ICON = CreateObjectSprite(window.bbox_right - 17.5 - 10, window.y + 3, LAYER_2 , ICON, OJustGUI, "IMAGE", TAG + "TOP_ICON" + string(ID), OPTION);
	window.WINDOW_TOP_ICON.image_xscale = 0.7;
	window.WINDOW_TOP_ICON.image_yscale = 0.7;
	window.ID = ID;
	window.WINDOW_TAG = TAG;
	window.MAIN_LAYER_ID = i;
	window.WINDOW_BK.WINDOW = window;
	window.LAYERS = [Gp0, Gp1, Gp2, Gp3, Gp4];
	global.layer_depth[i][2] = window;
	
	for (var i = 0; ON_MAIN_SCENE.TASKS[i] != undefined && ON_MAIN_SCENE.TASKS[i][0] != TAG; ) { i++; }
	
	if (ON_MAIN_SCENE.TASKS[i] != undefined) {
		for (var k = 0; ON_MAIN_SCENE.TASKS[k] != undefined; k++) {
			for (var l = 0; ON_MAIN_SCENE.TASKS[k][3][l] != undefined; l++) {
				ON_MAIN_SCENE.TASKS[k][3][l].ON = false;
				ON_MAIN_SCENE.TASKS[k][3][l].FIRST_TAKE = false;
			}
				
		}
		ON_MAIN_SCENE.TASKS[i][1] += 1;
		for (var e = 0; ON_MAIN_SCENE.TASKS[i][2][e] != undefined; ) { e++; }
		ON_MAIN_SCENE.TASKS[i][2][e] = [ID, true];
		ON_MAIN_SCENE.TASKS[i][2][e + 1] = undefined;
		for (var l = 0;  ON_MAIN_SCENE.TASKS[i][3][l] != undefined; ) { l++; }
		ON_MAIN_SCENE.TASKS[i][3][l] = window;
		ON_MAIN_SCENE.TASKS[i][3][l + 1] = undefined;
		ON_MAIN_SCENE.TASKS[i][4] += 1;
		if (string_count("-", NAME) == 0)
			NAME = NAME + " - " + string(ON_MAIN_SCENE.TASKS[i][4]);
		else {
			var news = "";
			for (var e = 0; string_char_at(NAME, e) != "-"; e++)
				news += string_char_at(NAME, e + 1);
			news += " " + string(ON_MAIN_SCENE.TASKS[i][4]);
			NAME = news;
		}
	} else {
		var new_class = [TAG, 1, [[ID, true], undefined], [window, undefined]];
		ON_MAIN_SCENE.TASKS[i] = new_class;
		ON_MAIN_SCENE.TASKS[i + 1] = undefined;
		ON_MAIN_SCENE.TASKS[i][4] = 1;
		NAME = NAME + " - " + string(ON_MAIN_SCENE.TASKS[i][4]);
	}
	
	var ORIGINAL_NAME = "";
	for (var e = 0; string_char_at(NAME, e + 1) != " "; e++)
		ORIGINAL_NAME += string_char_at(NAME, e + 1);
	window.TEXT_TITLE = AddText(x + 10, y + 3, NAME, Arial10, c_black, LAYER_2, TAG + "TITLE" + string(ID), [["CENTERED"], ["FADE_IN", 0.000005], undefined]);
	var icon = GetObject(TAG + "_TASK_ICON");
	var task_bar = GetObject("MAIN_TASKBAR");
	// ICON
	if (icon == undefined) {
		for (var X = 0; ON_MAIN_SCENE.ICONS[X] != undefined; ) { X++; }
		if (X - 1 < 0 || ON_MAIN_SCENE.ICONS[X - 1] == undefined)
			var pos = task_bar.x;
		else
			var pos = ON_MAIN_SCENE.ICONS[X - 1].x;
		icon = CreateObjectSprite(pos, task_bar.y - 3, "TaskBar_Gp1", ICON, Owindow_icon_tasks, "BUTTON-NO-HAND", TAG + "_TASK_ICON", [["INFO", ORIGINAL_NAME], undefined]);
		icon.WINDOW = i;
		addtolist(icon, ON_MAIN_SCENE.ICONS);
		window.ON_OBJECT = CreateObjectSprite(task_bar.x, task_bar.y + 12, "TaskBar_Gp2", S_on_task, OJustGUI, "IMAGE", TAG + "ON_TASK", [undefined]);
		icon.image_xscale = 0;
		icon.image_yscale = 0;
	} else {
		window.ON_OBJECT = GetObject(TAG + "ON_TASK");
		if (window.ON_OBJECT == undefined) {
			window.ON_OBJECT = CreateObjectSprite(task_bar.x, task_bar.y + 12, "TaskBar_Gp2", S_on_task, OJustGUI, "IMAGE", TAG + "ON_TASK", [undefined]);
			icon.WINDOW = i;
		}
	}

	icon.CREATE_WINDOW_IMAGE = WINDOW_BK;
	icon.CREATE_WINDOW_TAG = TAG;
	icon.CREATE_WINDOW_ICON = ICON;
	icon.CREATE_WINDOW_NAME = NAME;
	icon.CREATE_WINDOW_TOP = TOP_WINDOW;
	icon.ON_TASK = window.ON_OBJECT;
	icon.WINDOW_TAG = TAG;
	icon.CREATE_WINDOW_OBJECT = WINDOW_BK_OBJECT;
	window.image_alpha = 0;
	window.WINDOW_BK.image_alpha = 0;
	window.WINDOW_BK.WINDOW_TAG = window.TAG;
	window.CLOSE.image_alpha = 0;
	window.REDUCE.image_alpha = 0;
	window.ICON = icon;
	window.NAME = NAME;
	window.WINDOW_BK.WINDOW = window;
	window.INDEX = i;
	window.NUMBER = ON_MAIN_SCENE.TASKS[i][4];
	ID += 1;
	return window;
}

function CreateWindowIcon(WINDOW_BK, WINDOW_BK_OBJECT, TAG, ICON, NAME, TOP_WINDOW) {
	static ID = 500;
	
	for (var i = 0; ON_MAIN_SCENE.TASKS[i] != undefined && ON_MAIN_SCENE.TASKS[i][0] != TAG; ) { i++; }
	
	var new_class = [undefined, 1, [undefined], [undefined]];
	ON_MAIN_SCENE.TASKS[i] = new_class;
	ON_MAIN_SCENE.TASKS[i + 1] = undefined;
	ON_MAIN_SCENE.TASKS[i][4] = 0;
	var new_name = "";
	for (var g = 1; g < string_byte_length(NAME) && string_char_at(NAME, g) != "-"; g++)
		new_name = new_name + string_char_at(NAME, g);
	NAME = new_name;

	var ORIGINAL_NAME = "";
	for (var e = 0; string_char_at(NAME, e + 1) != " "; e++)
		ORIGINAL_NAME += string_char_at(NAME, e + 1);
	var task_bar = GetObject("MAIN_TASKBAR");
	// ICON
	var icon = CreateObjectSprite(task_bar.x, task_bar.y - 3, "TaskBar_Gp1", ICON, Owindow_icon_tasks, "BUTTON-NO-HAND", TAG + "_TASK_ICON", [["INFO", ORIGINAL_NAME], undefined]);
	addtolist(icon, ON_MAIN_SCENE.ICONS);
	icon.WINDOW = i;
	icon.image_xscale = 1;
	icon.image_yscale = 1;
	icon.CREATE_WINDOW_IMAGE = WINDOW_BK;
	icon.CREATE_WINDOW_TAG = TAG;
	icon.CREATE_WINDOW_ICON = ICON;
	icon.CREATE_WINDOW_NAME = NAME;
	icon.CREATE_WINDOW_TOP = TOP_WINDOW;
	icon.ON_TASK = undefined;
	icon.PIN = true;
	icon.WINDOW_TAG = TAG;
	icon.CREATE_WINDOW_OBJECT = WINDOW_BK_OBJECT;
	ID += 1;
}