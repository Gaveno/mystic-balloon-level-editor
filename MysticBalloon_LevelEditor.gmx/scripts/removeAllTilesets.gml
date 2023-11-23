//////////////////////////////
//  removeAllTilesets()
//  start fresh from no loaded
//  tilesets

for(var i = 0; i < tilesetsTotal; i++)
{
    tilesets[i] = -1;
}
tilesetsTotal = 0;

file_delete("workinglist.txt");
