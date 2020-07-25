  import 'package:flutter/material.dart';

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  LinearGradient linearGradient(String first, String second){
    return LinearGradient(colors:[colorFromHex(first),colorFromHex(second)]);
  }