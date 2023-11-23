/// getIndexName(objindex);
// returns the name of the index

var indx;
indx = argument0;

switch (indx) {
    case 0: return "Solid";
    case 1: return "Start";
    case 2: return "Finish";
    case 3: return "Walker";
    case 4: return "Fan";
    case 5: return "Spikes";
    case 6: return "Coin";
    case 7: return "Key";
    default: return "Unused";
}
