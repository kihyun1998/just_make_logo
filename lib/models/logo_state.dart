import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../utils/export_utils.dart';
import 'color_preset.dart';

enum LogoMode { textOnly, imageOnly, textAndImage, svgOnly }

enum ImagePosition { top, bottom, left, right }

enum ImageFitMode { contain, cover, fill }

class LogoState {
  final String selectedFont;
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

  const LogoState({
    this.logoMode = LogoMode.textOnly,
    this.selectedFont = 'Workbench',
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
  });

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
  }) {
    return LogoState(
      logoMode: logoMode ?? this.logoMode,
      selectedFont: selectedFont ?? this.selectedFont,
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
    );
  }
}

const _sentinel = Object();
