/// levelLoad(fname, array, a_w, a_h);
// Loads the level from a file that was
// saved with levelSave.
// This is not code for the Arduboy.
//
// File format: Each cell is one byte.
// Starts top left moves right.

var fname, file, array, aw, ah;

fname = argument0;
array = argument1;
aw = argument2;
ah = argument3;

file = file_bin_open(fname, BIN_READ);

for (var b = 0; b < ah; b++) { // y
    for (var a = 0; a < aw; a++) { // x
        array[@ a, b].objIndex = -1;
        array[@ a, b].solid = file_bin_read_byte(file);
    }
}

while (file_bin_position(file) != file_bin_size(file)) {
    var __x, __y, __id, __h, __w;
    __h = 0;
    __w = 0;
    __x = file_bin_read_byte(file);
    __y = file_bin_read_byte(file);
    __id = file_bin_read_byte(file);
    if (__id == 3) {
        __h = file_bin_read_byte(file);
        show_debug_message("fan height - 0: " + string(__h));
        if (__h >= 128) {
            if (__h >= 192) {
                // facing left
                __w = -(__h - 192);
                __h = 0;
                show_debug_message("fan height - 1: " + string(__h));
            }
            else {
                // facing right
                __w = __h - 128;
                __h = 0;
                show_debug_message("fan height - 2: " + string(__h));
            }
        }
        array[@ __x, __y].depth = -1;
        array[@ __x, __y].solid = true;
    }
    if (__id == 4) {
        var l = __x >> 5;
        __x &= 31;
        array[@ __x, __y].length = l;
        array[@ __x, __y].depth = -1;
    }
    array[@ __x, __y].objIndex = __id;
    array[@ __x, __y].height = __h;
    array[@ __x, __y].width = __w;
}

file_bin_close(file);

with objCell {
    cellGetSolid();
}
