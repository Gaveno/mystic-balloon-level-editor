/////////////////////////////////////////////
//  gotoRoom(file, room n)
//  seek to the line that room n starts at
//  returns -1 if  fails

var file, rmI, line, rmCurrent;
file = argument0;
rmI = max(argument1, 1);

rmCurrent = 0;

line = file_text_read_string(file);
while(!file_text_eof(file))
{
    if (stringFirstWord(line) == "const")
    {
        rmCurrent++;
        if (rmCurrent == rmI)
        {
            //file_text_readln(file);
            return 0;
        }
    }
    
    line = file_text_read_string(file);
    file_text_readln(file);
}

return -1;
