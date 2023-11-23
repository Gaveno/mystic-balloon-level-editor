////////////////////////////////////
//  getRooms(filename)
//  returns the total number of
//  room arrays are in a file

var file, filename, total, line;
total = 0;
filename = argument0;

if (file_exists(filename))
    file = file_text_open_read(filename);
else
    return 0;
    
line = file_text_read_string(file);

while(!file_text_eof(file))
{
    if (string(stringFirstWord(line)) == "const")
        total++;
        
    file_text_readln(file);
    line = file_text_read_string(file);
}

file_text_close(file);

return total;
