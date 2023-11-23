//////////////////////////
//  Load(room file);

var filename, file, rmI, totalRooms, line;

filename = argument0;

if (file_exists(filename))
{
    totalRooms = getRooms(filename);
    
    if (totalRooms > 0)
    {
        rmI = clamp(get_integer("Pick room to load. Enter 1-"+string(totalRooms),1), 0, totalRooms);
    }
    else
    {
        show_message("Error: No rooms in file");
        return -1;
    }
}

file = file_text_open_read(filename);
if (gotoRoom(file, rmI) == -1)
{
    file_text_close(file);
    show_message("Error: Room does not exist in file");
}

//  Load width and height
line = file_text_read_string(file);
var line, linet;

linet = stringFirstWord(line);
show_debug_message("W line: "+linet);
gridW = real(string_digits(linet));

linet = stringChopN(line, ' ', 2);
show_debug_message("H line: "+linet);
gridH = real(string_digits(linet));

file_text_readln(file);

//show_debug_message("New Grid W: "+string(gridW));
//show_debug_message("New Grid H: "+string(gridH));

//  clear room to load fresh
with objParent
{
        instance_destroy();
}

//  Load and execute commands
while(!file_text_eof(file) && stringFirstWord(line) != "0xFF,")
{
    var command;
    line = file_text_read_string(file);
    show_debug_message("Current line: "+line);
    //  End of room
    if (stringFirstWord(line) != "0xFF,")
    {
        command = stringChop(stringFirstWord(line), ',');
        var known = false;
        //show_debug_message("Command: "+command);
        
        //  ADD_TILE
        if (command == "ADD_TILE")
        {
            known = true; //recognized command
            //  Load arguments
            //show_debug_message("First Argument: "+stringChopN(line, ' ', 2));
            var ti = real(string_digits(stringChopN(line, ' ', 2)));
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 3))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 4))) * 32);
            var ts = real(string_digits(stringChopN(line, ' ', 5)));
            
            //show_debug_message("Tile Index: "+string(ti));
            
            //  Create Tile
            var tile = instance_create(tx, ty, objTile);
            tile.tileset = floor((ti - 1) / 9);
            tile.tile = (ti % 9) - 1;
            tile.solid = ts;
        }
        
        //  ADD_TILE_RECT
        if (command == "ADD_TILE_RECT")
        {
            known = true; //recognized command
            //  Load arguments
            var ti = real(string_digits(stringChopN(line, ' ', 2)));
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 3))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 4))) * 32);
            var tw = real(string_digits(stringChopN(line, ' ', 5)));
            var th = real(string_digits(stringChopN(line, ' ', 6)));
            var ts = real(string_digits(stringChopN(line, ' ', 7)));
            
            //  Create rectangle object
            var tile = instance_create(tx, ty, objRect);
            tile.tileset = floor((ti - 1) / 9);
            tile.tile = (ti % 9) - 1;
            tile.width = tw;
            tile.height = th;
            tile.solid = ts;
        }
        
        //  ADD_WALL_V
        if (command == "ADD_WALL_V")
        {
            known = true; //recognized command
            //  Load arguments
            var ti = real(string_digits(stringChopN(line, ' ', 2)));
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 3))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 4))) * 32);
            var tl = real(string_digits(stringChopN(line, ' ', 5)));
            var ts = real(string_digits(stringChopN(line, ' ', 6)));
            
            //  Create rectangle object
            var tile = instance_create(tx, ty, objWall);
            tile.tileset = floor((ti - 1) / 9);
            tile.tile = (ti % 9) - 1;
            tile.length = tl;
            tile.type = 1;
            tile.solid = ts;
        }
        
        //  ADD_WALL_H
        if (command == "ADD_WALL_H")
        {
            known = true; //recognized command
            //  Load arguments
            var ti = real(string_digits(stringChopN(line, ' ', 2)));
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 3))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 4))) * 32);
            var tl = real(string_digits(stringChopN(line, ' ', 5)));
            var ts = real(string_digits(stringChopN(line, ' ', 6)));
            
            //  Create rectangle object
            var tile = instance_create(tx, ty, objWall);
            tile.tileset = floor((ti - 1) / 9);
            tile.tile = (ti % 9) - 1;
            tile.length = tl;
            tile.type = 0;
            tile.solid = ts;
        }
        
        //  CREATE_DOOR
        if (command == "CREATE_DOOR")
        {
            known = true; //recognized command
            //  Load arguments
            var ds = real(string_digits(stringChopN(line, ' ', 2)));
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 3))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 4))) * 32);
            var dx = real(string_digits(stringChopN(line, ' ', 5)));
            var dy = real(string_digits(stringChopN(line, ' ', 6)));
            var isx = real(string_digits(stringChopN(line, ' ', 7)));
            var isy = real(string_digits(stringChopN(line, ' ', 8)));
            
            //  Create door object
            var tile = instance_create(tx, ty, objDoor);
            tile.destRoom = ds;
            tile.destX = dx;
            tile.destY = dy;
            tile.image_xscale = isx;
            tile.image_yscale = isy;
            show_debug_message("Door ds: "+string(ds)+" x: "+string(tx)+" y: "+string(ty)+" dx: "+string(dx)+" dy: "+string(dy)+" isx: "+string(isx)+" isy: "+string(isy));
        }
        
        //  custom command
        if (!known)
        {
            //unrecognized command
            file_text_readln(file);
            var argnum = real(string_digits(file_text_read_string(file)));
            show_debug_message("Argument count for Custom: "+string(argnum));
            file_text_readln(file);
            line = file_text_read_string(file);
            //  Load arguments
            var tx = offx + (real(string_digits(stringChopN(line, ' ', 1))) * 32);
            var ty = offy + (real(string_digits(stringChopN(line, ' ', 2))) * 32);
            if (argnum > 2)
                var a0 = real(string_digits(stringChopN(line, ' ', 3)));
            if (argnum > 3)
                var a1 = real(string_digits(stringChopN(line, ' ', 4)));
            if (argnum > 4)
                var a2 = real(string_digits(stringChopN(line, ' ', 5)));
            
            //  Create door object
            var tile = instance_create(tx, ty, objCustom);
            tile.com = command;
            tile.argnum = argnum;
            if (argnum > 4)
                tile.arg[2] = a2;
            if (argnum > 3)
                tile.arg[1] = a1;
            if (argnum > 2)
                tile.arg[0] = a0;
            //show_debug_message("Door ds: "+string(ds)+" x: "+string(tx)+" y: "+string(ty)+" dx: "+string(dx)+" dy: "+string(dy)+" isx: "+string(isx)+" isy: "+string(isy));
        }
        
    }
    file_text_readln(file);
}

return 0;
