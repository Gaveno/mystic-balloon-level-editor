//////////////////////////////////
//  addTileset(fname)
//  add a tileset to the working
//  list of tilesets

var fname = argument0;

if (file_exists(fname))
{
    tilesets[tilesetsTotal] = sprite_add(fname, 9, false, false, 0, 0);
    tilesetsTotal++;
    
    var file = file_text_open_append("workinglist.txt");
    file_text_write_string(file, fname);
    file_text_writeln(file);
    file_text_close(file);
}
    
