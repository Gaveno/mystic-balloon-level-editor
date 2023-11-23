/// findLastSlash(string)

var str = argument0;
var index = 0;

for (var i = 0; i < string_length(str); i++) {
    if (string_char_at(str, i) == '/' || string_char_at(str, i) == '\') {
        index = i + 1;
    }
}

return index;
