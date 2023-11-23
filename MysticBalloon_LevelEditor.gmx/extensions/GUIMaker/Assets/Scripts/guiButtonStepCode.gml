///////////////////////////
//  guiButtonStepCode();
//
//  sets the button to
//  pressed or not
//
///////////////////////////

//mouseguix = xtoguix(mouse_x);
//mouseguiy = ytoguiy(mouse_y);
if (myReleased) {
    myReleased = false;
}
if (myGUI.Visible && fake = false) {

/*if (os_type == os_ios || os_type = os_android) {
    x_av = device_mouse_raw_x(0);
    y_av = device_mouse_raw_y(0);
} else {
    //x_av = (mouse_x-view_xview)*2;
    //y_av = (mouse_y-view_yview)*2;
    x_av = window_mouse_get_x();
    y_av = window_mouse_get_y();
}
mouseguix = x_av;
mouseguiy = y_av;*/

mouseguix = mouse_x;
mouseguiy = mouse_y;



if (mouseguix > x && mouseguix < x+myWidth) &&
    (mouseguiy > y && mouseguiy < y+myHeight) {
    if (mouse_check_button_pressed(mb_left) && !myPressed) {
        myPressed = true;
        myStateChange = true;
    }
    if (mouse_check_button_released(mb_left) && myPressed) {
        myPressed = false;
        myReleased = true;
        myStateChange = true;
    }
} else {
    if (myPressed) {
        myStateChange = true;
        myPressed = false;
    }
}

}