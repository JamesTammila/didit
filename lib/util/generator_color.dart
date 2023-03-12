import 'dart:math';
import 'package:flutter/material.dart';

Color generateColor() {
  final Random random = Random();
  final int red = 30 + random.nextInt(76);
  final int green = 30 + random.nextInt(76);
  final int blue = 30 + random.nextInt(76);
  final int alpha = 50 + random.nextInt(206);
  return Color.fromARGB(alpha, red, green, blue);
}