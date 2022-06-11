/// @On MainScene Create
// You can write your code in this editor

// WINDOWS
TASKS = [undefined];
N_WINDOW = 0;
N_WINDOW_LIMITED = 15;
ON_GUI = false;

// SLIDER
DESK_SLIDER = false;
DESK_SLIDER_OBJECT = undefined;

// ICONS
ICONS = [undefined];


PATH = global.PATH;
// FOLDERS
if (global.FOLDERS != undefined) {
	NAME_FOLDERS = global.FOLDERS;
	FOLDERS = [undefined];
	for (var i = 0; NAME_FOLDERS[i] != undefined; i++) {
		show_message(NAME_FOLDERS);
		var folder = AddFolders(NAME_FOLDERS[i], "START");
		FOLDERS[i] = folder;
		FOLDERS[i + 1] = undefined;
		for (var e = 1; PATH[1][e] != undefined && PATH[1][e][0][0][0] != NAME_FOLDERS[i][0]; ) { e++;}
		if (PATH[1][e] != undefined)
			PATH[1][e][0][0][2] = folder;
	}
} else {
	NAME_FOLDERS = [undefined];
	FOLDERS = [undefined];
}

// DESK
ON_DESK = true;


if (PATH == undefined || PATH == undefined) {
	PATH = [[["~", "ROOT"]], undefined];
	var get = terminal_mkdir(["mkdir", "Desk", "Documents", undefined], undefined, PATH, undefined, "/~"); PATH = get[0];
}

CURSOR = CreateObjects(960, 540, "Cursor",  Ocursor, "CURSOR", "CURSOR", [undefined]);
CreateObjectSprite(0, 0, "Background_Gp0", S_backgrounds, OJustGUI, "IMAGE", "MAIN_BACKGROUNDS", [["INDEX_IMAGE", global.USER[7]], ["FADE_IN", 0.00001], undefined]);
TASKBAR = CreateObjectSprite(960, 1040, "TaskBar_Gp0", S_taskbar, OJustGUI, "IMAGE", "MAIN_TASKBAR", [["FADE_IN", 0.00001], undefined]);

// PIN
for (var i = 0; global.WINDOWS_PIN[i] != undefined; i++) {
	var class = global.WINDOWS_PIN[i];
	if (!class[0])
		continue;
	CreateWindowIcon(class[1], class[2], class[3], class[4], class[5]);
}