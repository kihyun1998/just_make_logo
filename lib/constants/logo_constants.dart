import 'package:flutter/material.dart';

import '../models/group_preset.dart';
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

  static const List<GroupPreset> groupPresets = [
    GroupPreset(
      label: 'Android',
      icon: IconLabel.android,
      sizes: [
        SizePreset('mdpi_48x48', 48, 48),
        SizePreset('hdpi_72x72', 72, 72),
        SizePreset('xhdpi_96x96', 96, 96),
        SizePreset('xxhdpi_144x144', 144, 144),
        SizePreset('xxxhdpi_192x192', 192, 192),
        SizePreset('playstore_512x512', 512, 512),
      ],
    ),
    GroupPreset(
      label: 'iOS',
      icon: IconLabel.apple,
      sizes: [
        SizePreset('20x20', 20, 20),
        SizePreset('29x29', 29, 29),
        SizePreset('40x40', 40, 40),
        SizePreset('60x60', 60, 60),
        SizePreset('76x76', 76, 76),
        SizePreset('83.5x83.5', 84, 84),
        SizePreset('1024x1024', 1024, 1024),
        SizePreset('20x20@2x', 40, 40),
        SizePreset('20x20@3x', 60, 60),
        SizePreset('29x29@2x', 58, 58),
        SizePreset('29x29@3x', 87, 87),
        SizePreset('40x40@2x', 80, 80),
        SizePreset('40x40@3x', 120, 120),
        SizePreset('60x60@2x', 120, 120),
        SizePreset('60x60@3x', 180, 180),
        SizePreset('76x76@2x', 152, 152),
        SizePreset('83.5x83.5@2x', 167, 167),
      ],
    ),
    GroupPreset(
      label: 'Web',
      icon: IconLabel.web,
      sizes: [
        SizePreset('favicon_16x16', 16, 16),
        SizePreset('favicon_32x32', 32, 32),
        SizePreset('apple-touch_180x180', 180, 180),
        SizePreset('android-chrome_192x192', 192, 192),
        SizePreset('android-chrome_512x512', 512, 512),
        SizePreset('og-image_1200x630', 1200, 630),
      ],
    ),
    GroupPreset(
      label: 'macOS',
      icon: IconLabel.apple,
      sizes: [
        SizePreset('16x16', 16, 16),
        SizePreset('32x32', 32, 32),
        SizePreset('64x64', 64, 64),
        SizePreset('128x128', 128, 128),
        SizePreset('256x256', 256, 256),
        SizePreset('512x512', 512, 512),
        SizePreset('1024x1024', 1024, 1024),
      ],
    ),
    GroupPreset(
      label: 'Windows',
      icon: IconLabel.windows,
      sizes: [
        SizePreset('16x16', 16, 16),
        SizePreset('24x24', 24, 24),
        SizePreset('32x32', 32, 32),
        SizePreset('48x48', 48, 48),
        SizePreset('64x64', 64, 64),
        SizePreset('256x256', 256, 256),
      ],
    ),
  ];
}
