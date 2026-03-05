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
    SizePreset('16 x 16', 16, 16),
    SizePreset('32 x 32', 32, 32),
    SizePreset('48 x 48', 48, 48),
    SizePreset('96 x 96', 96, 96),
    SizePreset('128 x 128', 128, 128),
    SizePreset('192 x 192', 192, 192),
    SizePreset('256 x 256', 256, 256),
    SizePreset('512 x 512', 512, 512),
    SizePreset('1024 x 1024', 1024, 1024),
    SizePreset('1280 x 720', 1280, 720),
    SizePreset('1920 x 1080', 1920, 1080),
    SizePreset('Custom', 0, 0),
  ];
}
