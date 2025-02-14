/// @Project by Kucia Guillaume* ///


if (TAG == undefined)
	return;
// ON_WRITE
if (ON_WRITE && PASSED == 0) {
	BAR.visible = true;
	PASSED = 1
} else if (!ON_WRITE && PASSED == 1) {
	BAR.visible = false;
	PASSED = 0;
}

// RE-USE THE INITIAL TEXT
if (TEXT_INDEX_MAX <= 0 && !ON_WRITE) {
	TEXT[0] = INITIAL_TEXT;
	TEXT[1] = "";
	TEXT_INDEX_MAX = 1;
	TEXT_INDEX = 1;
}

// UPDATE BAR
BAR.INDEX = TEXT_INDEX;
BAR.INDEX_MAX = TEXT_INDEX_MAX;

// TEXT OUTPUT
TEXT_OUTPUT = "";
if (TEXT != undefined && TEXT_OUTPUT != undefined) {
	for (var i = 0; i < TEXT_INDEX_MAX; i++) {
		if (TEXT[i] != undefined)
			TEXT_OUTPUT = TEXT_OUTPUT + TEXT[i];
		else
			TEXT_OUTPUT = "";
	}
}

if (!ON_WRITE)
	return;

// MOVE TEXT INDEX
if (KeyPressed(vk_left)) { if (TEXT_INDEX > 0) { TEXT_INDEX -= 1; } return; }
if (KeyPressed(vk_right)) { if (TEXT_INDEX < TEXT_INDEX_MAX) { TEXT_INDEX += 1; } return; }

// Delete char
if (KeyPress(vk_backspace) && !KeyPressed(vk_backspace))
	TIME += delta_time / 1000000;
if ((KeyPress(vk_backspace) && TIME >= 0.2) || KeyPressed(vk_backspace)) {
	BAR.visible = true;
	if (KeyPressed(vk_backspace))
		TIME = 0;
	BAR.TIME = 0;
	if (TEXT_INDEX <= 0)
		return;
	for (var i = TEXT_INDEX; i != TEXT_INDEX_MAX; i++) {
		TEXT[i - 1] = TEXT[i];
	}
	TEXT_INDEX_MAX -= 1;
	TEXT_INDEX -= 1;
	return;
}

if (KeyPressed(vk_enter)) {
	ON_WRITE = false;
	return;
}

if ((KeyPressed(vk_tab) || KeyPressed(vk_up) || KeyPressed(vk_down)) && ON_WRITE && !TAB) {
	
	
	for (var i = 0; global.WRITE[i][0] != TAG;) { i++ };
	ON_WRITE = false;
	var get = undefined;
	if (global.WRITE[i + 1] != undefined && global.WRITE[i + 1][1] == room && !KeyPressed(vk_up)) {
		get = global.WRITE[i + 1][2];
		get.ON_WRITE = true;
		get.TAB = true;
	} else {
		for (var i = 0; global.WRITE[i] != undefined && global.WRITE[i][1] != room;) { i++ }
		if (global.WRITE[i] == undefined)
			return;
		get = global.WRITE[i][2];
		get.ON_WRITE = true;
		get.TAB = true;
	}
	return;
} else if ((KeyPressed(vk_tab) || KeyPressed(vk_enter)|| KeyPressed(vk_up) || KeyPressed(vk_down)) && ON_WRITE)  {
	TAB = false;
	return;
}

// CHECK INPUT
if ((KeyPress(vk_backspace) || TEXT_INDEX_MAX >= MAX || KeyPressed(vk_alt) || KeyPressed(vk_control) ||
keyboard_lastkey == 20) && keyboard_lastchar != ".")
	return;

// WRITE ON TEXT
if (keyboard_check_pressed(vk_anykey) && ON_WRITE && ((keyboard_lastkey >= 32 && keyboard_lastkey <= 177) || keyboard_lastchar == ".")) {
	if (TEXT[0] == INITIAL_TEXT && TEXT_INDEX == 1) {
		TEXT_INDEX -= 1;
		TEXT_INDEX_MAX -= 1;
	}
	KEY = keyboard_lastchar;
	BAR.visible = true;
	BAR.TIME = 0;
	if (KeyPress(vk_control) && (KeyPressed(ord("M")) || KeyPressed(ord("T"))))
		return;
	TEXT_INDEX_MAX += 1;
	for (var b = TEXT_INDEX; b != TEXT_INDEX_MAX;) { b++; }
	for (; b != TEXT_INDEX; b--)
		TEXT[b] = TEXT[b - 1];
	TEXT[TEXT_INDEX] = KEY;
	TEXT_INDEX += 1;
}
