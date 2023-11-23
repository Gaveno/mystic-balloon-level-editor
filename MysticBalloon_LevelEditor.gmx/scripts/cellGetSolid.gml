/// cellGetSolid();
// checks the surroundings of a cell for solid surroundings
// and assigns the correct sub index.

var top, left, right, bottom, smallstep, bigstep, f;
smallstep = 24;
bigstep = 24;

top = !place_free(x, y - smallstep);
left = !place_free(x - smallstep, y);
right = !place_free(x + bigstep, y);
bottom = !place_free(x, y + bigstep);

f = 0;
f = right | (top << 1) | (left << 2) | (bottom << 3);
image_index = f;
/*f |= top << 3;
f |= left << 2;
f |= right << 1;
f |= bottom;

switch (f) {
    case 3: image_index = 0; break;
    case 7: image_index = 1; break;
    case 5: image_index = 2; break;
    case 11: image_index = 3; break;
    case 15: image_index = 4; break; // solid all around
    case 13: image_index = 5; break;
    case 10: image_index = 6; break;
    case 14: image_index = 7; break;
    case 12: image_index = 8; break;
    default: image_index = 4;
}*/
