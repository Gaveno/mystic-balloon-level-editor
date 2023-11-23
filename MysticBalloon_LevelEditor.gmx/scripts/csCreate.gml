#define csCreate
////////////////////////////////////////////////////////////
//  csCreate();
//creates a command stack to be used with the other cs scripts
//returns the id;
////////////////////////////////////////////////////////////
var cs, cs_scripts, cs_arguments;
cs = ds_list_create();
cs_scripts = ds_list_create();
cs_arguments = ds_list_create();
ds_list_add(cs,cs_scripts,cs_arguments);
cs_runtime = 0;
cs_draw_runtime = 0;
return cs;

#define csAddCommand
////////////////////////////////////////////////////////////
//  csAddCommand(cs, script, arg0, arg1, ...);
//add a command to the end of a command stack
// arguments for the command script are optional
// the script must return 0 if incomplete,
// and 1 for complete (remove from cs)
////////////////////////////////////////////////////////////
var cs, cs_scripts, cs_arguments, script, cs_arglist;
cs = argument[0];
script = argument[1];
cs_scripts = ds_list_find_value(cs,0);
cs_arguments = ds_list_find_value(cs,1);
ds_list_add(cs_scripts,script);
cs_runtime = 0;
if (argument_count > 2) {
    var i;
    cs_arglist = ds_list_create();
    for (i = 2; i < argument_count; i++) {
        ds_list_add(cs_arglist,argument[i]);
        /*if (is_real(argument[i])) {
            show_message(string(argument[i]));
        } else {
            show_message(argument[i]);
        }*/
    }
    ds_list_add(cs_arguments,cs_arglist);
} else {
    ds_list_add(cs_arguments,-1);
}

#define csInsertCommand
////////////////////////////////////////////////////////////
//  csInsertCommand(cs, pos, script, arg0, arg1, ...);
// insert a command to t'pos' of a command stack
// arguments for the command script are optional
// the script must return 0 if incomplete,
// and 1 for complete (remove from cs)
/////////////////////////////////////////////////////////////
var cs, cs_scripts, cs_arguments, script, cs_arglist, pos;
cs = argument[0];
script = argument[2];
pos = argument[1];
cs_scripts = ds_list_find_value(cs,0);
cs_arguments = ds_list_find_value(cs,1);
ds_list_insert(cs_scripts,pos,script);
cs_runtime = 0;
if (argument_count > 3) {
    var i;
    cs_arglist = ds_list_create();
    for (i = 3; i < argument_count; i++) {
        ds_list_add(cs_arglist,argument[i]);
    }
    ds_list_insert(cs_arguments,pos,cs_arglist);
} else {
    ds_list_insert(cs_arguments,pos,-1);
}

#define csStep
////////////////////////////////////////////////////////////
//  csStep(cs);
// steps a command stack.
// if the script returns 1 it is removed from the cs
// if it returns 0 it will continue to run as long
// as a new script is not inserted on top of it
////////////////////////////////////////////////////////////
var cs, cs_scripts, cs_arguments, cs_arglist, script;
cs = argument[0];
if (!ds_exists(cs,ds_type_list))
    return CS_NOT_EXIST;
cs_scripts = ds_list_find_value(cs,0);
cs_arguments = ds_list_find_value(cs,1);
if (!ds_exists(cs_scripts,ds_type_list))
    return CS_NOT_EXIST;
if (!ds_exists(cs_arguments,ds_type_list))
    return CS_NOT_EXIST;
if (ds_list_size(cs_scripts) <= 0) {
    exit;
}
script = ds_list_find_value(cs_scripts,0);
cs_arglist = ds_list_find_value(cs_arguments,0);
cs_draw = false;
//if argument1 is true cs_draw is true
if (argument_count > 1) {
    if (argument[1] == true) {
        cs_draw = true;
    }
}
var ret;
//show_message(ds_list_size(cs_arglist));
if (script_exists(script)) {
    if (!ds_exists(cs_arglist,ds_type_list)) {
        ret = script_execute(script);
    } else {
        switch (ds_list_size(cs_arglist)) {
            case 1: ret = script_execute(script,ds_list_find_value(cs_arglist,0)); break;
            case 2: ret = script_execute(script,ds_list_find_value(cs_arglist,0)
            ,ds_list_find_value(cs_arglist,1)); break;
            case 3:  ret = script_execute(script,ds_list_find_value(cs_arglist,0)
            ,ds_list_find_value(cs_arglist,1),ds_list_find_value(cs_arglist,2)); break;
            case 4: ret = script_execute(script,ds_list_find_value(cs_arglist,0)
            ,ds_list_find_value(cs_arglist,1),ds_list_find_value(cs_arglist,2)
            ,ds_list_find_value(cs_arglist,3)); break;
            case 5: ret = script_execute(script,ds_list_find_value(cs_arglist,0)
            ,ds_list_find_value(cs_arglist,1),ds_list_find_value(cs_arglist,2)
            ,ds_list_find_value(cs_arglist,3),ds_list_find_value(cs_arglist,4)); break;
        }
    }
    if (cs_draw) {
        cs_draw_runtime++;
    } else {
        cs_runtime++;
    }
}
// show_message(string(ret));
if (ret == 1) { //delete script from cs
    if (cs_draw) {
        cs_draw_runtime = 0;
    } else {
        cs_runtime = 0;
    }
    if (ds_exists(cs_arglist,ds_type_list))
        ds_list_destroy(cs_arglist);
    ds_list_delete(cs_scripts,0);
    ds_list_delete(cs_arguments,0);
    return 1;
}
return ret;

#define csDestroy
////////////////////////////////////////////////////////////
//  csDestroy(cs);
// destroys all data structures associated with the command stack
////////////////////////////////////////////////////////////
var cs, cs_scripts, cs_arguments, cs_arglist;
cs = argument[0];
if (!ds_exists(cs,ds_type_list))
    return CS_NOT_EXIST;
cs_scripts = ds_list_find_value(cs,0);
cs_arguments = ds_list_find_value(cs,1);
if (!ds_exists(cs_scripts,ds_type_list))
    return CS_NOT_EXIST;
if (!ds_exists(cs_arguments,ds_type_list))
    return CS_NOT_EXIST;
if (!ds_list_empty(cs_arguments)) {
    var i;
    for(i=0;i < ds_list_size(cs_arguments); i++) {
        if (ds_exists(ds_list_find_value(cs_arguments,i),ds_type_list)) {
            ds_list_destroy(ds_list_find_value(cs_arguments,i));
        }
    }
}
ds_list_destroy(cs_scripts);
ds_list_destroy(cs_arguments);
ds_list_destroy(cs);
return 1;

#define csGetCommand
////////////////////////////////////////////////////////////
//  csGetCommand(cs, pos);
//returns the script at position pos
// pos = 0 is current script being run
////////////////////////////////////////////////////////////
var cs, cs_scripts, pos, script;
cs = argument0;
pos = argument1;
cs_scripts = ds_list_find_value(cs,0);
script = ds_list_find_value(cs_scripts,pos);
return script;

#define csGetSize
////////////////////////////////////////////////////////////
//  csGetSize(cs);
//returns the size of the command stack
////////////////////////////////////////////////////////////
var cs, cs_scripts;
cs = argument0;
cs_scripts = ds_list_find_value(cs,0);
return ds_list_size(cs_scripts);

#define csDeleteCommand
////////////////////////////////////////////////////////////
//  csDeleteCommand(cs,pos);
//deletes the command at pos
////////////////////////////////////////////////////////////
var cs, cs_arguments, cs_scripts, pos;
cs = argument0;
pos = argument1;
cs_scripts = ds_list_find_value(cs,0);
cs_arguments = ds_list_find_value(cs,1);
ds_list_delete(cs_scripts,pos);
ds_list_delete(cs_arguments,pos);