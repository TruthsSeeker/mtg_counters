import 'dart:ui';

import 'package:flutter/material.dart';

// Based on Gacek's StackOverflow answer
// https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color

extension ContrastingColor on Color {
  contrastingBWColor(){
  //   // Calculate the perceptive luminance (aka luma) - human eye favors green color...
  // double luma = ((0.299 * this.red) + (0.587 * this.green) + (0.114 * this.blue)) / 255;
  //
  // // Return black for bright colors, white for dark colors
  // return luma > 0.5 ? Colors.black : Colors.white;
    return Colors.white;
  }
}