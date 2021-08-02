import 'package:flutter/material.dart';


Widget NumberButton({context,title,titlecolor,color,opacitycolor,height,width}){
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: opacitycolor,
    ),
    child: Center(
      child: Text(title,style: TextStyle(color: titlecolor,fontWeight: FontWeight.bold,fontSize: 20),),
    ),
  );
}

Widget iconbutton({context,icon,iconcolor,color,opacitycolor,height,width}){
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: opacitycolor,
    ),
    child: Center(
      child: Icon(icon,size: 30,color: iconcolor,)
    ),
  );
}