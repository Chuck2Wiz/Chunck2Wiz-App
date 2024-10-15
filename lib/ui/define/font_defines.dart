import 'package:flutter/material.dart';
import 'color_defines.dart';

class FontDefines {
  static TextStyle bottomBarActive = const TextStyle(
    color: ColorDefines.mainColor,
    fontSize: 10,
    fontFamily: 'DMSans',
  );

  static TextStyle bottomBarDeactivate = const TextStyle(
    color: ColorDefines.primaryGray,
    fontSize: 10,
    fontFamily: 'DMSans',
  );

  static TextStyle writeText = const TextStyle(
    color: ColorDefines.mainColor,
    fontSize: 14,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.bold
  );

  static TextStyle black18Bold = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.bold
  );

  static TextStyle main15Normal = const TextStyle(
      color: ColorDefines.mainColor,
      fontSize: 15,
      fontFamily: 'DMSans',
  );

  static TextStyle deactiviate15 = const TextStyle(
    color: ColorDefines.primaryGray,
    fontSize: 15,
    fontFamily: 'DMSans',
  );

  static TextStyle normal15 = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'DMSans',
  );

  static TextStyle gray12 = const TextStyle(
    color: ColorDefines.primaryGray,
    fontSize: 12,
    fontFamily: 'DMSans',
  );
}