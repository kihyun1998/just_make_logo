import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../utils/export_utils.dart';
import 'color_preset.dart';

enum LogoMode { textOnly, imageOnly, textAndImage, svgOnly }

enum ImagePosition { top, bottom, left, right }

enum ImageFitMode { contain, cover, fill }

enum BackgroundShape { rectangle, circle }

class LogoState {
  final String selectedFont;
  final int fontWeightValue;
  final Color backgroundColor;
  final Color textColor;
  final String selectedSize;
  final double canvasPadding;
  final double textPadding;
  final int maxLines;
  final ExportFormat exportFormat;
  final int exportScale;
  final bool isExporting;
  final List<ColorPreset> colorPresets;
  final Uint8List? imageBytes;
  final ImagePosition imagePosition;
  final double imageFlexRatio;
  final double imageGap;
  final ImageFitMode imageFitMode;
  final LogoMode logoMode;
  final String? svgString;
  final bool transparentBackground;
  final double exportBorderRadius;
  final BackgroundShape backgroundShape;

  const LogoState({
    this.logoMode = LogoMode.textOnly,
    this.selectedFont = 'Workbench',
    this.fontWeightValue = 400,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.selectedSize = '512 x 512',
    this.canvasPadding = 0.0,
    this.textPadding = 0.0,
    this.maxLines = 1,
    this.exportFormat = ExportFormat.png,
    this.exportScale = 1,
    this.isExporting = false,
    this.colorPresets = const [],
    this.imageBytes,
    this.imagePosition = ImagePosition.top,
    this.imageFlexRatio = 0.5,
    this.imageGap = 8,
    this.imageFitMode = ImageFitMode.contain,
    this.svgString,
    this.transparentBackground = false,
    this.exportBorderRadius = 0.0,
    this.backgroundShape = BackgroundShape.rectangle,
  });

  static const Map<int, String> weightLabels = {
    100: 'Thin (100)',
    200: 'ExtraLight (200)',
    300: 'Light (300)',
    400: 'Regular (400)',
    500: 'Medium (500)',
    600: 'SemiBold (600)',
    700: 'Bold (700)',
    800: 'ExtraBold (800)',
    900: 'Black (900)',
  };

  static FontWeight valueToFontWeight(int value) {
    switch (value) {
      case 100: return FontWeight.w100;
      case 200: return FontWeight.w200;
      case 300: return FontWeight.w300;
      case 500: return FontWeight.w500;
      case 600: return FontWeight.w600;
      case 700: return FontWeight.w700;
      case 800: return FontWeight.w800;
      case 900: return FontWeight.w900;
      case 400:
      default: return FontWeight.w400;
    }
  }

  FontWeight get fontWeight => valueToFontWeight(fontWeightValue);

  bool get hasImage => imageBytes != null;
  bool get hasSvg => svgString != null;
  bool get showText =>
      logoMode == LogoMode.textOnly || logoMode == LogoMode.textAndImage;
  bool get showImage =>
      logoMode == LogoMode.imageOnly || logoMode == LogoMode.textAndImage;
  bool get showSvg => logoMode == LogoMode.svgOnly;

  LogoState copyWith({
    LogoMode? logoMode,
    String? selectedFont,
    int? fontWeightValue,
    Color? backgroundColor,
    Color? textColor,
    String? selectedSize,
    double? canvasPadding,
    double? textPadding,
    int? maxLines,
    ExportFormat? exportFormat,
    int? exportScale,
    bool? isExporting,
    List<ColorPreset>? colorPresets,
    Object? imageBytes = _sentinel,
    Object? svgString = _sentinel,
    ImagePosition? imagePosition,
    double? imageFlexRatio,
    double? imageGap,
    ImageFitMode? imageFitMode,
    bool? transparentBackground,
    double? exportBorderRadius,
    BackgroundShape? backgroundShape,
  }) {
    return LogoState(
      logoMode: logoMode ?? this.logoMode,
      selectedFont: selectedFont ?? this.selectedFont,
      fontWeightValue: fontWeightValue ?? this.fontWeightValue,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      selectedSize: selectedSize ?? this.selectedSize,
      canvasPadding: canvasPadding ?? this.canvasPadding,
      textPadding: textPadding ?? this.textPadding,
      maxLines: maxLines ?? this.maxLines,
      exportFormat: exportFormat ?? this.exportFormat,
      exportScale: exportScale ?? this.exportScale,
      isExporting: isExporting ?? this.isExporting,
      colorPresets: colorPresets ?? this.colorPresets,
      imageBytes: imageBytes == _sentinel
          ? this.imageBytes
          : imageBytes as Uint8List?,
      imagePosition: imagePosition ?? this.imagePosition,
      imageFlexRatio: imageFlexRatio ?? this.imageFlexRatio,
      imageGap: imageGap ?? this.imageGap,
      imageFitMode: imageFitMode ?? this.imageFitMode,
      svgString: svgString == _sentinel ? this.svgString : svgString as String?,
      transparentBackground:
          transparentBackground ?? this.transparentBackground,
      exportBorderRadius: exportBorderRadius ?? this.exportBorderRadius,
      backgroundShape: backgroundShape ?? this.backgroundShape,
    );
  }
}

const _sentinel = Object();
