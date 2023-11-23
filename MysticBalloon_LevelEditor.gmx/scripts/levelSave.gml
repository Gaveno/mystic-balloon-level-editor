/// levelSave(fname, array, a_w, a_h);
// Saves the level to a file that can
// easily be read into the level editor.
// This is not code for the Arduboy.
//
// File format: Each cell is one byte.
// Starts top left moves right.

var fname, file, array, aw, ah;

fname = argument0;
array = argument1;
aw = argument2;
ah = argument3;

file = file_bin_open(fname, BIN_WRITE);

for (var b = 0; b < ah; b++) { // y
    for (var a = 0; a < aw; a++) { // x
        file_bin_write_byte(file, array[a, b].solid);
    }
}

with objCell {
    if (objIndex > -1) {
        if (length > 0 && objIndex == 4)
            file_bin_write_byte(file, ((x - control.gridStartX) / control.gridCellW) | (length << 5));
        else
            file_bin_write_byte(file, (x - control.gridStartX) / control.gridCellW);
        file_bin_write_byte(file, (y - control.gridStartY) / control.gridCellH);
        file_bin_write_byte(file, objIndex);
        if (objIndex == 3) {
            if (height > 0)
                file_bin_write_byte(file, height);
            else if (width > 0)
                file_bin_write_byte(file, width + 128);
            else file_bin_write_byte(file, abs(width) + 192);
        }
    }
}

file_bin_close(file);
