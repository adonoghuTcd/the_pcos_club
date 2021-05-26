import 'package:flutter/material.dart';


class CustomColour {
  static primary() {
    Map<int, Color> color ={50:Color.fromRGBO(136,14,79, .1),
      100:Color.fromRGBO(243, 93, 109, .2),
      200:Color.fromRGBO(243, 93, 109, .3),
      300:Color.fromRGBO(243, 93, 109, .4),
      400:Color.fromRGBO(243, 93, 109, .5),
      500:Color.fromRGBO(243, 93, 109, .6),
      600:Color.fromRGBO(243, 93, 109, .7),
      700:Color.fromRGBO(243, 93, 109, .8),
      800:Color.fromRGBO(243, 93, 109, .9),
      900:Color.fromRGBO(243, 93, 109, 1),};
    return MaterialColor(0xFFF35D6D, color);
  }
}