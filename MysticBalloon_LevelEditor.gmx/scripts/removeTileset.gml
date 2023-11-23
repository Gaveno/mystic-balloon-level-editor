///////////////////////////////
//  removeTileset(index)
//  removes the tileset from
//  the working list

var index = argument0;
var file;
file[0] = file_text_open_read("workinglist.txt");
file[1] = file_text_open_write("templist.txt");

//  Copy working list skipping index to delete
var i = 0;
while(!file_text_eof(file[0]))
{
    if (i != index)
    {
        file_text_write_string(file[1],file_text_read_string(file[0]));
    }
    file_text_writeln(file[1]);
    file_text_readln(file[0]);
    i++;
}

//  Close files
file_text_close(file[0]);
file_text_close(file[1]);

//  Remove working list and rename the temp
file_delete("workinglist.txt");
file_rename("templist.txt", "workinglist.txt");

//  Remove tileset from list array
var templist;
i = 0;
for (var t = 0; t < tilesetsTotal; t++)
{
    if (t != index)
    {
        tilesets[i] = tilesets[t];
        i++;
    }
}

tilesetsTotal--;
