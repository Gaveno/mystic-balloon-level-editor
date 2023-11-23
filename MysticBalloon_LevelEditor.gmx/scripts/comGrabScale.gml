//////////////////////////////
//  comGrabScale();
//  grab an object to adjust
//  scale

if (cs_runtime == 0)
{
    startDX = mouse_x - x;
    startDY = mouse_y - y;
    startX = mouse_x;
    startY = mouse_y;
}

if (canScaleX)
if (abs(mouse_x - startX) > 16)
{
    image_xscale = clamp(ceil((mouse_x + startDX - startX) / 32), 1, 16);
    length = floor(image_xscale / 2);
    W = length * 32;
}

if(canScaleY)
if (abs(mouse_y - startY) > 16)
{
    image_yscale = clamp(ceil((mouse_y + startDY - startY) / 32), 1, 16);
    length = floor(image_yscale / 2);
    H = length * 32;
}

return !(mouse_check_button(mb_left));
