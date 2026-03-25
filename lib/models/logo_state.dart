import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../utils/export_utils.dart';
import 'color_preset.dart';

enum LogoMode { textOnly, imageOnly, textAndImage, svgOnly }

enum ImagePosition { top, bottom, left, right }

enum ImageFitMode { contain, cover, fill }

enum BackgroundShape { rectangle, circle }

enum GradientType { linear, radial }

enum GradientDirection {
  topToBottom,
  bottomToTop,
  leftToRight,
  rightToLeft,
  topLeftToBottomRight,
  topRightToBottomLeft,
  bottomLeftToTopRight,
  bottomRightToTopLeft,
}

class GradientPreset {
  final String name;
  final Color startColor;
  final Color endColor;
  final GradientType type;
  final GradientDirection direction;

  const GradientPreset({
    required this.name,
    required this.startColor,
    required this.endColor,
    this.type = GradientType.linear,
    this.direction = GradientDirection.topLeftToBottomRight,
  });
}

const gradientPresets = [
  GradientPreset(
    name: 'Sunset',
    startColor: Color(0xFFFF6B6B),
    endColor: Color(0xFFFFE66D),
  ),
  GradientPreset(
    name: 'Ocean',
    startColor: Color(0xFF667EEA),
    endColor: Color(0xFF764BA2),
  ),
  GradientPreset(
    name: 'Mint',
    startColor: Color(0xFF11998E),
    endColor: Color(0xFF38EF7D),
  ),
  GradientPreset(
    name: 'Peach',
    startColor: Color(0xFFED6EA0),
    endColor: Color(0xFFEC8C69),
  ),
  GradientPreset(
    name: 'Night',
    startColor: Color(0xFF0F2027),
    endColor: Color(0xFF2C5364),
  ),
  GradientPreset(
    name: 'Berry',
    startColor: Color(0xFF8E2DE2),
    endColor: Color(0xFF4A00E0),
  ),
  GradientPreset(
    name: 'Fire',
    startColor: Color(0xFFFF416C),
    endColor: Color(0xFFFF4B2B),
  ),
  GradientPreset(
    name: 'Sky',
    startColor: Color(0xFF56CCF2),
    endColor: Color(0xFF2F80ED),
  ),
  GradientPreset(
    name: 'Lime',
    startColor: Color(0xFFA8E063),
    endColor: Color(0xFF56AB2F),
  ),
  GradientPreset(
    name: 'Royal',
    startColor: Color(0xFF141E30),
    endColor: Color(0xFF243B55),
  ),
];

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
  final bool useGradient;
  final Color gradientEndColor;
  final GradientType gradientType;
  final GradientDirection gradientDirection;

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
    this.useGradient = false,
    this.gradientEndColor = const Color(0xFF000000),
    this.gradientType = GradientType.linear,
    this.gradientDirection = GradientDirection.topLeftToBottomRight,
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

  Map<String, dynamic> toPresetJson(String text) {
    return {
      'text': text,
      'selectedFont': selectedFont,
      'fontWeightValue': fontWeightValue,
      'backgroundColor': backgroundColor.toARGB32(),
      'textColor': textColor.toARGB32(),
      'selectedSize': selectedSize,
      'canvasPadding': canvasPadding,
      'textPadding': textPadding,
      'maxLines': maxLines,
      'exportFormat': exportFormat.name,
      'exportScale': exportScale,
      'logoMode': logoMode.name,
      'imagePosition': imagePosition.name,
      'imageFlexRatio': imageFlexRatio,
      'imageGap': imageGap,
      'imageFitMode': imageFitMode.name,
      'transparentBackground': transparentBackground,
      'exportBorderRadius': exportBorderRadius,
      'backgroundShape': backgroundShape.name,
      'useGradient': useGradient,
      'gradientEndColor': gradientEndColor.toARGB32(),
      'gradientType': gradientType.name,
      'gradientDirection': gradientDirection.name,
    };
  }

  static ({LogoState state, String text}) fromPresetJson(
      Map<String, dynamic> json) {
    return (
      text: json['text'] as String? ?? 'HELLO',
      state: LogoState(
        selectedFont: json['selectedFont'] as String? ?? 'Workbench',
        fontWeightValue: json['fontWeightValue'] as int? ?? 400,
        backgroundColor:
            Color(json['backgroundColor'] as int? ?? 0xFFFFFFFF),
        textColor: Color(json['textColor'] as int? ?? 0xFF000000),
        selectedSize: json['selectedSize'] as String? ?? '512 x 512',
        canvasPadding: (json['canvasPadding'] as num?)?.toDouble() ?? 0.0,
        textPadding: (json['textPadding'] as num?)?.toDouble() ?? 0.0,
        maxLines: json['maxLines'] as int? ?? 1,
        exportFormat: ExportFormat.values.firstWhere(
          (e) => e.name == json['exportFormat'],
          orElse: () => ExportFormat.png,
        ),
        exportScale: json['exportScale'] as int? ?? 1,
        logoMode: LogoMode.values.firstWhere(
          (e) => e.name == json['logoMode'],
          orElse: () => LogoMode.textOnly,
        ),
        imagePosition: ImagePosition.values.firstWhere(
          (e) => e.name == json['imagePosition'],
          orElse: () => ImagePosition.top,
        ),
        imageFlexRatio:
            (json['imageFlexRatio'] as num?)?.toDouble() ?? 0.5,
        imageGap: (json['imageGap'] as num?)?.toDouble() ?? 8,
        imageFitMode: ImageFitMode.values.firstWhere(
          (e) => e.name == json['imageFitMode'],
          orElse: () => ImageFitMode.contain,
        ),
        transparentBackground:
            json['transparentBackground'] as bool? ?? false,
        exportBorderRadius:
            (json['exportBorderRadius'] as num?)?.toDouble() ?? 0.0,
        backgroundShape: BackgroundShape.values.firstWhere(
          (e) => e.name == json['backgroundShape'],
          orElse: () => BackgroundShape.rectangle,
        ),
        useGradient: json['useGradient'] as bool? ?? false,
        gradientEndColor:
            Color(json['gradientEndColor'] as int? ?? 0xFF000000),
        gradientType: GradientType.values.firstWhere(
          (e) => e.name == json['gradientType'],
          orElse: () => GradientType.linear,
        ),
        gradientDirection: GradientDirection.values.firstWhere(
          (e) => e.name == json['gradientDirection'],
          orElse: () => GradientDirection.topLeftToBottomRight,
        ),
      ),
    );
  }

  static const Map<GradientDirection, (Alignment, Alignment)> _gradientAligns = {
    GradientDirection.topToBottom: (Alignment.topCenter, Alignment.bottomCenter),
    GradientDirection.bottomToTop: (Alignment.bottomCenter, Alignment.topCenter),
    GradientDirection.leftToRight: (Alignment.centerLeft, Alignment.centerRight),
    GradientDirection.rightToLeft: (Alignment.centerRight, Alignment.centerLeft),
    GradientDirection.topLeftToBottomRight: (Alignment.topLeft, Alignment.bottomRight),
    GradientDirection.topRightToBottomLeft: (Alignment.topRight, Alignment.bottomLeft),
    GradientDirection.bottomLeftToTopRight: (Alignment.bottomLeft, Alignment.topRight),
    GradientDirection.bottomRightToTopLeft: (Alignment.bottomRight, Alignment.topLeft),
  };

  Gradient? get backgroundGradient {
    if (!useGradient) return null;
    final colors = [backgroundColor, gradientEndColor];
    if (gradientType == GradientType.radial) {
      return RadialGradient(colors: colors);
    }
    final aligns = _gradientAligns[gradientDirection]!;
    return LinearGradient(
      begin: aligns.$1,
      end: aligns.$2,
      colors: colors,
    );
  }

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
    bool? useGradient,
    Color? gradientEndColor,
    GradientType? gradientType,
    GradientDirection? gradientDirection,
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
      useGradient: useGradient ?? this.useGradient,
      gradientEndColor: gradientEndColor ?? this.gradientEndColor,
      gradientType: gradientType ?? this.gradientType,
      gradientDirection: gradientDirection ?? this.gradientDirection,
    );
  }
}

const _sentinel = Object();
