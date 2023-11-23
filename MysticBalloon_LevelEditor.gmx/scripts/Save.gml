/////////////////////////////////////////////
//  Save(filename, internalname);

global.bytesActual = 2;

filename = argument0;
iname = argument1;

grid = ds_grid_create(gridW, gridH);

ds_grid_set_region(grid, 0, 0, gridW - 1, gridH - 1, 0);

global.file = file_text_open_append(filename);

file_text_write_string(global.file, "// Room: "+iname+" Width: "+string(gridW)
    + " Height: "+string(gridH)+" ");
file_text_writeln(global.file);

file_text_write_string(global.file, "const uint8_t "+iname+" [] PROGMEM = {");
file_text_writeln(global.file);
file_text_write_string(global.file, string(gridW)+", "+string(gridH)+",");
file_text_writeln(global.file);

with objRect
{

    /*file_text_write_string(global.file, "  ADD_TILE_RECT, "+string((tileset * 9) + tile + 1)+", ");
    file_text_write_string(global.file, string((x - objControl.offx) / 32)+", ");
    file_text_write_string(global.file, string((y - objControl.offy) / 32)+", ");
    file_text_write_string(global.file, string(width)+", ");
    file_text_write_string(global.file, string(height)+", ");
    file_text_write_string(global.file, string(solid)+", ");
    file_text_writeln(global.file);
    global.bytesActual += 7;*/
    
    var xx = (x - objControl.offx) / 32;
    var yy = (y - objControl.offy) / 32;
    ds_grid_set_region(objControl.grid, xx, yy, xx + width - 1, yy + height - 1, solid);
}

with objTile
{
    /*var ti = (tileset * 9) + tile + 1;
    if (ti <= 0)
        ti = 9;
    file_text_write_string(global.file, "  ADD_TILE, "+string(ti)+", ");
    file_text_write_string(global.file, string((x - objControl.offx) / 32)+", ");
    file_text_write_string(global.file, string((y - objControl.offy) / 32)+", ");
    file_text_write_string(global.file, string(solid)+", ");
    file_text_writeln(global.file);
    global.bytesActual += 5;*/
    
    var xx = (x - objControl.offx) / 32;
    var yy = (y - objControl.offy) / 32;
    ds_grid_set(objControl.grid, xx, yy, solid);
}

with objWall
{
    /*if (type)
        file_text_write_string(global.file, "  ADD_WALL_V, "+string((tileset * 9) + tile + 1)+", ");
    else
        file_text_write_string(global.file, "  ADD_WALL_H, "+string((tileset * 9) + tile + 1)+", ");
    file_text_write_string(global.file, string((x - objControl.offx) / 32)+", ");
    file_text_write_string(global.file, string((y - objControl.offy) / 32)+", ");
    file_text_write_string(global.file, string(length)+", ");
    file_text_write_string(global.file, string(solid)+", ");
    file_text_writeln(global.file);
    global.bytesActual += 6;*/
    
    var xx = (x - objControl.offx) / 32;
    var yy = (y - objControl.offy) / 32;
    
    if (type)
    {
        width = 1;
        height = length;
    }
    else
    {
        width = length;
        height = length;
    }
    ds_grid_set_region(objControl.grid, xx, yy, xx + width - 1, yy + height - 1, solid);
}

with objDoor
{
    /*file_text_write_string(global.file, "  CREATE_DOOR, "+string(destRoom)+", ");
    file_text_write_string(global.file, string((x - objControl.offx) / 32)+", ");
    file_text_write_string(global.file, string((y - objControl.offy) / 32)+", ");
    file_text_write_string(global.file, string(destX)+", ");
    file_text_write_string(global.file, string(destY)+", ");
    file_text_write_string(global.file, string(image_xscale)+", ");
    file_text_write_string(global.file, string(image_yscale)+", ");
    file_text_writeln(global.file);
    global.bytesActual += 8;*/
}

byteListSize = (gridW * gridH) / 8;
byteList[byteListSize] = 0;

for (var a = 0; a < gridW; a++)
{
    for (var b = 0; b < gridH; b++)
    {
        byteList[floor(a / 8) + (b * (gridW / 8))] |= ds_grid_get(grid, a, b) << (a % 8);
    }
}

for (var i = 0; i < byteListSize; i++)
{
    file_text_write_string(global.file, string(byteList[i])+", ");
    if (i % 4 == 3)
        file_text_writeln(global.file);
}

with objCustom
{
    file_text_write_string(global.file, "  "+com+", ");
    file_text_writeln(global.file);
    file_text_write_string(global.file,"  //"+string(argnum)+" ");
    file_text_writeln(global.file);
    file_text_write_string(global.file, "  "+string((x - objControl.offx) / 32)+", ");
    file_text_write_string(global.file, string((y - objControl.offy) / 32)+", ");
    if (argnum > 2)
        file_text_write_string(global.file, string(arg[0])+", ");
    if (argnum > 3)
        file_text_write_string(global.file, string(arg[1])+", ");
    if (argnum > 4)
        file_text_write_string(global.file, string(arg[2])+", ");
    file_text_writeln(global.file);
    global.bytesActual += 6;
}

file_text_write_string(global.file, "0xFF,");
global.bytesActual += 1;
file_text_writeln(global.file);
file_text_write_string(global.file, "};");
file_text_writeln(global.file);
file_text_write_string(global.file, "// Total Bytes: "+string(global.bytesActual)+" Saved: "+string((gridW*gridH) - global.bytesActual));
file_text_writeln(global.file);
file_text_writeln(global.file);

file_text_close(global.file);
