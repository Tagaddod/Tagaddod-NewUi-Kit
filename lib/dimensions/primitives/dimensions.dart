import 'package:flutter/material.dart';

class Dimensions {
  static const double borderRadius0 = 0;
  static const double borderRadius050 = 2;
  static const double borderRadius100 = 4;
  static const double borderRadius200 = 8;
  static const double borderRadius300 = 12;
  static const double borderRadius600 = 24;
  static const double borderRadius800 = 32;
  static const double borderRadiusFull = 9999;

  static const double space0 = 0;
  static const double space025 = 1;
  static const double space050 = 2;
  static const double space100 = 4;
  static const double space200 = 8;
  static const double space300 = 12;
  static const double space400 = 16;
  static const double space500 = 20;
  static const double space600 = 24;
  static const double space800 = 32;
  static const double space1000 = 40;
  static const double space1200 = 48;
  static const double space1600 = 64;
  static const double space2000 = 80;
  static const double space2400 = 96;
  static const double space3200 = 128;

  static const double borderWidth25 = 1;
  static const double borderWidth050 = 2;
  static const double borderWidth100 = 4;

  //Elevation
  static const BoxShadow elevationShadow100 = BoxShadow(
    color: Color(0xff16161d12),
    offset: Offset(1, 0),
  );

  static const BoxShadow elevationShadow200 = BoxShadow(
    color: Color.fromRGBO(22, 22, 29, 0.07), // Convert RGBA to Flutter Color
    offset: Offset(0, 3), // X: 0px, Y: 3px
    blurRadius: 1, // Blur radius: 1px
    spreadRadius: -1,
  );

  static const BoxShadow elevationShadow300 = BoxShadow(
    color: Color.fromRGBO(22, 22, 29, 0.20), // Convert RGBA to Flutter Color
    offset: Offset(0, 4), // X: 0px, Y: 3px
    blurRadius: 6, // Blur radius: 1px
    spreadRadius: -2,
  );

  static const BoxShadow elevationShadow400 = BoxShadow(
    color: Color.fromRGBO(22, 22, 29, 0.22), // Convert RGBA to Flutter Color
    offset: Offset(0, 8), // X: 0px, Y: 3px
    blurRadius: 16, // Blur radius: 1px
    spreadRadius: -4,
  );

  static const BoxShadow elevationShadow500 = BoxShadow(
    color: Color.fromRGBO(22, 22, 29, 0.24), // Convert RGBA to Flutter Color
    offset: Offset(0, 12), // X: 0px, Y: 3px
    blurRadius: 20, // Blur radius: 1px
    spreadRadius: -8,
  );

  static const BoxShadow elevationShadow600 = BoxShadow(
    color: Color.fromRGBO(22, 22, 29, 0.28), // Convert RGBA to Flutter Color
    offset: Offset(0, 20), // X: 0px, Y: 3px
    blurRadius: 20, // Blur radius: 1px
    spreadRadius: -8,
  );
}
