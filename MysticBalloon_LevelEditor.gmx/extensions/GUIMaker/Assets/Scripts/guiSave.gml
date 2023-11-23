///////////////////////////////////////
//  guiSave(guiID,fname);
//  saves the guiID to fname
//
//  version 01.01
///////////////////////////////////////

var guiID, fname, file;

guiID = argument0;
fname = argument1;

file = file_bin_open(fname, 1);

file_bin_write_byte(file, ord("G"));
file_bin_write_byte(file, ord("U"));
file_bin_write_byte(file, ord("I"));
file_bin_write_byte(file, ord(" "));
file_bin_write_byte(file, ord("0"));
file_bin_write_byte(file, ord("1"));
file_bin_write_byte(file, ord("."));
file_bin_write_byte(file, ord("0"));
file_bin_write_byte(file, ord("1"));
file_bin_write_byte(file, ord(" "));
file_bin_write_byte(file, ord(" "));
file_bin_write_byte(file, ord(" "));

file_bin_write_short(file,guiID.myWidth);
file_bin_write_short(file,guiID.myHeight);

file_bin_write_short(file,ds_list_size(guiID.myDrawList)); //list size

for (i=0;i<ds_list_size(guiID.myDrawList);i++) {
    var obj;
    obj = ds_list_find_value(guiID.myDrawList,i);
    
    file_bin_write_byte(file,obj.myType);
    if (obj.myType == GUI_TYPE_LIST) {
        file_bin_write_string(file,ds_list_write(obj.myList));
        //file_bin_write_byte(file,obj.type);
        file_bin_write_byte(file,obj.myListType);
        file_bin_write_short(file,obj.myListSep);
        file_bin_write_byte(file,obj.myListSnap);
    }
    file_bin_write_byte(file,i);
    file_bin_write_short(file,obj.myWidth);
    file_bin_write_short(file,obj.myHeight);
    file_bin_write_byte(file,color_get_red(obj.myColor));
    file_bin_write_byte(file,color_get_green(obj.myColor));
    file_bin_write_byte(file,color_get_blue(obj.myColor));
    file_bin_write_string(file,obj.myText);
    //file_bin_write_short(file,obj.myTextCol);
    file_bin_write_byte(file,color_get_red(obj.myTextCol));
    file_bin_write_byte(file,color_get_green(obj.myTextCol));
    file_bin_write_byte(file,color_get_blue(obj.myTextCol));
    file_bin_write_string(file,font_get_name(obj.myFont));
    file_bin_write_string(file,obj.myCustomScript);
    file_bin_write_short(file,obj.myPressedCol);
    file_bin_write_byte(file,obj.myTextStretched);
    file_bin_write_byte(file,obj.myTextPos);
    file_bin_write_byte(file,obj.mySpritePos);
    file_bin_write_byte(file,obj.myOnlyText);
    file_bin_write_byte(file,obj.myCornerRadius);
    file_bin_write_short(file,obj.x+300-EDIT_START_X);
    file_bin_write_short(file,obj.y+300-EDIT_START_Y);
    file_bin_write_byte(file,obj.myAlpha_Back * 100);
    file_bin_write_byte(file,obj.myAlpha_Border * 100);
    file_bin_write_byte(file,obj.myAlpha_Text * 100);
}

file_bin_close(file);