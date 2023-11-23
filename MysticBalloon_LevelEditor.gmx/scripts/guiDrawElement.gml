//////////////////////////////////////////////////////
//                  drawElement(element ID);
//
//              draws a gui element
//            using it's local variables
//
//          COPYRIGHT 2014 (C) Monkey Studios
//////////////////////////////////////////////////////
var elID, xx, yy, xx2, yy2, colMed, colLight, colDark, rad, text, textcol, font, colDarkest, lighter, darker, width, height;
elID = argument0;

lighter = 100;
darker = 50;
xx = elID.x-x;
yy = elID.y-y;
xx2 = xx+elID.myWidth;
yy2 = yy+elID.myHeight;
width = elID.myWidth;
height = elID.myHeight;
rad = elID.myCornerRadius;

if (!elID.myOnlyText) {
    if (elID.myType == GUI_TYPE_BUTTON && elID.myPressed) {
        colMed = c_dkgray;
    } else {
        colMed = elID.myColor;
    }
    
    colLight = make_color_rgb(min(color_get_red(colMed)+lighter,255),min(color_get_green(colMed)+lighter,255),min(color_get_blue(colMed)+lighter,255));
    //colDark is darker than the base
    colDark = make_color_rgb(max(color_get_red(colMed)-darker,0),max(color_get_green(colMed)-darker,0),max(color_get_blue(colMed)-darker,0));
    colDarkest = make_color_rgb(max(color_get_red(colMed)-darker-darker,0),max(color_get_green(colMed)-darker-darker,0),max(color_get_blue(colMed)-darker-darker,0));
    
    //button
    if (elID.myType == GUI_TYPE_BUTTON) {
        draw_set_alpha(elID.myAlpha_Back);
        draw_roundrect_color_ext(xx,yy,xx+width,yy+height,rad,rad,colLight,colDark,false);
        draw_set_color(colLight);
        draw_rectangle(xx+2,yy+2,xx+width-2,yy+(height/2),false);
        draw_set_alpha(elID.myAlpha_Border);
        draw_roundrect_ext(xx-1,yy-1,xx+width+1,yy+height+1,rad,rad,true);
        draw_roundrect_ext(xx-0.5,yy-0.5,xx+width+0.5,yy+height+0.5,rad,rad,true);
        draw_set_color(colMed);
        draw_roundrect_ext(xx,yy,xx+width,yy+height,rad,rad,true);
        draw_set_color(colDarkest);
        draw_roundrect_ext(xx+1,yy+1,xx+width-1,yy+height-1,rad,rad,true);
    }
    
    //box
    if (elID.myType == GUI_TYPE_BOX || elID.myType == GUI_TYPE_TEXT) {
        draw_set_alpha(elID.myAlpha_Back);
        draw_roundrect_color_ext(xx,yy,xx+width,yy+height,rad,rad,colMed,colMed,false);
        draw_set_alpha(elID.myAlpha_Border);
        draw_set_color(colLight);
        //draw_rectangle(xx+2,yy+2,xx+width-2,yy+(height/2),false);
        draw_roundrect_ext(xx-1,yy-1,xx+width+1,yy+height+1,rad,rad,true);
        draw_roundrect_ext(xx-0.5,yy-0.5,xx+width+0.5,yy+height+0.5,rad,rad,true);
        draw_set_color(colMed);
        draw_roundrect_ext(xx,yy,xx+width,yy+height,rad,rad,true);
        draw_set_color(colDarkest);
        draw_roundrect_ext(xx+1,yy+1,xx+width-1,yy+height-1,rad,rad,true);
    }
}

draw_set_font(elID.myFont);
draw_set_color(elID.myTextCol);
///////////////// SPRITE /////////////////////
if (elID.sprite_index > -1) {
    if (elID.mySpritePos == GUI_SPRITE_BT) {
        draw_sprite(elID.sprite_index,elID.image_index,round(xx+(width/2)-(string_width(elID.myText)*0.30)),round(yy+(height/2)));
    }
    if (elID.mySpritePos == GUI_SPRITE_AT) {
        draw_sprite(elID.sprite_index,elID.image_index,round(xx+(width/2)+(string_width(elID.myText)*0.30)),round(yy+(height/2)));
    }
    if (elID.mySpritePos == GUI_SPRITE_CENTER) {
        draw_sprite(elID.sprite_index,elID.image_index,round(xx+(width/2)),round(yy+(height/2)));
    }
}

///////////////// TEXT //////////////////////
if (elID.myText != " ") {
    if (elID.sprite_index > -1) {
        if (elID.mySpritePos == GUI_SPRITE_BT) {
            xx += sprite_get_width(elID.sprite_index)*.75;
        }
        if (elID.mySpritePos == GUI_SPRITE_AT) {
            //show_message(string(sprite_get_width(elID.sprite_index)*5));
            xx -= sprite_get_width(elID.sprite_index)*.75;
        }
    }
    
    if (elID.myTextStretched) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text_transformed(xx+(width/2),yy+(height/2),elID.myText,(width*0.9)/string_width(elID.myText),(height*0.95)/string_height(elID.myText),0);
        draw_set_alpha(1);
        exit;
    }
    //draw_set_font(elID.myFont);
    //draw_set_color(elID.myTextCol);
    if (elID.myTextPos == 1) {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.05)),round(yy+(height*0.05)),elID.myText);
    }
    if (elID.myTextPos == 2) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width/2)),round(yy+(height*0.05)),elID.myText);
    }
    if (elID.myTextPos == 3) {
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.95)),round(yy+(height*0.05)),elID.myText);
    }
    if (elID.myTextPos == 4) {
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.05)),round(yy+(height/2)),elID.myText);
    }
    if (elID.myTextPos == 5) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width/2)),round(yy+(height/2)),elID.myText);
    }
    if (elID.myTextPos == 6) {
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.95)),round(yy+(height/2)),elID.myText);
    }
    if (elID.myTextPos == 7) {
        draw_set_halign(fa_left);
        draw_set_valign(fa_bottom);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.05)),round(yy+(height*0.95)),elID.myText);
    }
    if (elID.myTextPos == 8) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width/2)),round(yy+(height*0.95)),elID.myText);
    }
    if (elID.myTextPos == 9) {
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_alpha(elID.myAlpha_Text);
        draw_text(round(xx+(width*0.95)),round(yy+(height*0.95)),elID.myText);
    }
    //draw_text_transformed(xx+(width/2),yy+(height/2),text,(width*0.8)/string_width(text),(height*0.6)/string_height(text),0);
}
draw_set_alpha(1);
