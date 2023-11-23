/// levelExport(fname, name, array, a_w, a_h);
// Export the level into a c header file to be used
// with the arduboy.
// Level is 24x24 cells

var fname, array, name, aw, ah, file;

fname = argument0;
name = argument1;
array = argument2;
aw = argument3;
ah = argument4;

file = file_text_open_write(fname);
file_text_write_string(file, "const uint8_t ");
file_text_write_string(file, name);
file_text_write_string(file, " [] PROGMEM = {");
file_text_writeln(file);
file_text_write_string(file, "// Tiles");
//file_text_writeln(file);

var byte = 0;
for (var b = 0; b < ah; b++) { // y
    if (b % 3 == 0)
        file_text_writeln(file);
        
    for (var a = 0; a < aw; a++) { // x
        if (a % 8 == 0) byte = 0;
        
        byte |= array[a, b].solid << (a % 8);
        //file_bin_write_byte(file, array[a, b].solid);
        if (a % 8 == 7) {
            file_text_write_string(file, "0x" + valueToHex(byte) + ", ");
        }
    }
}
file_text_writeln(file);
file_text_write_string(file, "// Objects");
file_text_writeln(file);

var endline = 0;

with objCell {
    if (objIndex > -1) {
        var bu, bl;
        bl = 0;
        bu = 0;
        //bu |= objIndex << 4;
        bu |= objIndex << 5;
        bu |= floor((y - control.gridStartY) / control.gridCellH);
        if (objIndex == 4 && length > 0)
            bl = floor((x - control.gridStartX) / control.gridCellW) | (length << 5);
        else
            bl = floor((x - control.gridStartX) / control.gridCellW);
        //bu |= (((y - control.gridStartY) / control.gridCellH) >> 2) & 23;
        //bl |= ((x - control.gridStartX) / control.gridCellW);// | (((y - control.gridStartY) / control.gridCellH) << 6);
        //file_text_write_string(file, "0x" + valueToHex(bu) + ",");
        //file_text_write_string(file, "0x" + valueToHex(bl) + ",");
        file_text_write_string(file, "B" + valueToBinary(bu) + ",");
        file_text_write_string(file, "B" + valueToBinary(bl) + ",");
        if ( objIndex == 3 ) {
            if (height > 0)
                //file_text_write_string(file, "0x" + valueToHex(height) + ",");
                file_text_write_string(file, "B" + valueToBinary(height) + ",");
            else if (width > 0)
                //file_text_write_string(file, "0x" + valueToHex(width + 128) + ",");
                file_text_write_string(file, "B" + valueToBinary(width + 128) + ",");
            else
                //file_text_write_string(file, "0x" + valueToHex(abs(width) + 192) + ",");
                file_text_write_string(file, "B" + valueToBinary(abs(width) + 192) + ",");
        }
        endline++;
        if (endline > 5) {
            endline = 0;
            file_text_writeln(file);
        }
    
    }
}
file_text_writeln(file);
file_text_write_string(file, "// EoL");
file_text_writeln(file);
file_text_write_string(file, "0xFF");
file_text_writeln(file);
file_text_write_string(file, "};");

file_text_close(file);
