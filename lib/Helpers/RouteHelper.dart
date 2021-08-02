import 'package:flutter/material.dart';

class RouteHelper {

  gotonext(context,secondscreen){

    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => secondscreen),
    );

  }


}