import 'package:flutter/material.dart';

import '../models/size_preset.dart';

class LogoConstants {
  static const List<String> fonts = ['Workbench', 'Jersey 20', 'Noto Serif'];

  static const List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  static const List<SizePreset> sizePresets = [
    SizePreset('512 x 512', 512, 512),
    SizePreset('1024 x 1024', 1024, 1024),
    SizePreset('192 x 192', 192, 192),
    SizePreset('Custom', 0, 0),
  ];
}
