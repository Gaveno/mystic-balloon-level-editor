/// valueToBinary(decvalue);

var hex = valueToHex(argument0);
var bout = "";

var i;
for (i = 1; i <= string_length(hex); i++) {
    switch (string_char_at(hex, i)) {
        case '0': bout += "0000"; break;
        case '1': bout += "0001"; break;
        case '2': bout += "0010"; break;
        case '3': bout += "0011"; break;
        case '4': bout += "0100"; break;
        case '5': bout += "0101"; break;
        case '6': bout += "0110"; break;
        case '7': bout += "0111"; break;
        case '8': bout += "1000"; break;
        case '9': bout += "1001"; break;
        case 'A': bout += "1010"; break;
        case 'B': bout += "1011"; break;
        case 'C': bout += "1100"; break;
        case 'D': bout += "1101"; break;
        case 'E': bout += "1110"; break;
        case 'F': bout += "1111"; break;
    }
}

return bout;
