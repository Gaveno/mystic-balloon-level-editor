/////////////////////////////////
//  removeLeadingSpace(string)
//  removes beginning spaces

var strin, strout;
strin = argument0;

if (string_char_at(strin, 1) != ' ')
    return strin;
    
var i = 0;
while(i < string_length(strin))
{
    i++;
    if (string_char_at(strin,i) != ' ')
    {
        strout = string_copy(strin, i, string_length(strin) - i);
        //show_debug_message("string in: "+strin+" string out: "+strout);
        return strout;
    }
}
return '';
