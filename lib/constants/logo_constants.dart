import 'package:flutter/material.dart';

import '../models/size_preset.dart';

class LogoConstants {
  static const List<String> fonts = [
    'Workbench',
    'Jersey 20',
    'Noto Serif',
    'Bebas Neue',
    'Pacifico',
    'Lobster',
    'Raleway',
    'Permanent Marker',
    'Black Han Sans',
    'Noto Sans KR',
  ];

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
    SizePreset('1920 x 1080', 1920, 1080),
    SizePreset('1280 x 720', 1280, 720),
    SizePreset('Custom', 0, 0),
  ];
}
