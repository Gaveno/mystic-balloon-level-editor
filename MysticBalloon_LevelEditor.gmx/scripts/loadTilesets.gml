//////////////////////////////////////
//  loadTilesets(fname)
//  load in tilesets from a list of
//  sprites in a text file

var currentTileset, fname, file, line, missingFiles;
fname = argument0;

if (!file_exists(fname))
{
    // No such file
    return -1;
}

file = file_text_open_read(fname);
var wfile = file_text_open_write("workinglist.txt");

currentTileset = 0;
missingFiles = 0;
while(!file_text_eof(file))
{
    line = file_text_read_string(file);
    if (file_exists(line))
    {
        tilesets[currentTileset] = sprite_add(line, 9, false, false, 0, 0);
        currentTileset++;
        file_text_write_string(wfile, line);
        file_text_writeln(wfile);
    }
    else
        missingFiles++;
    file_text_readln(file);
}

tilesetsTotal = currentTileset;

file_text_close(file);
file_text_close(wfile);

return missingFiles;
