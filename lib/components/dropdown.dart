import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

DropdownButton<String> androidDropdown({List menuItems, var dropdownBtnValue,
  Function onChanged}) {
  
  List<DropdownMenuItem<String>> androidDropdownMenuItems = [];
  menuItems.forEach((menuItem) {
      androidDropdownMenuItems.add(
        DropdownMenuItem(
            child: Text(menuItem),
            value: menuItem
          ),
      );
  });

  return DropdownButton<String>(
      value: dropdownBtnValue,
      items: androidDropdownMenuItems,
      onChanged: onChanged,
  );  
}

CupertinoPicker iosPicker({List menuItems, Color backgroundColor, 
  double itemExtent, Function onSelectedItemChanged, TextStyle textStyle}){
    
    // add menu item to List<Text>
    List<Text> cupertinoDropdownMenuItems = [];
    menuItems.forEach((menuItem) {
      cupertinoDropdownMenuItems.add(
        Text(menuItem,
          style: textStyle,
        ),
      );      
    });

    return CupertinoPicker(
      backgroundColor: backgroundColor,
      itemExtent: itemExtent,
      onSelectedItemChanged: onSelectedItemChanged,
      children: cupertinoDropdownMenuItems
    );
}