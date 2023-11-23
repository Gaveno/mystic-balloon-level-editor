///////////////////////////
//  comMove();
//  move an object


if (cs_runtime == 0)
{
    startDX = mouse_x - x;
    startDY = mouse_y - y;
}

x = clamp(round((mouse_x - startDX) / 32) * 32, objControl.offx, objControl.offx + (objControl.gridW * 32) - 32);
y = clamp(round((mouse_y - startDY) / 32) * 32, objControl.offy, objControl.offy + (objControl.gridH * 32) - 32);

return !(mouse_check_button(mb_left));
