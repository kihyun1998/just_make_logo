import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class LogoState {
  final String selectedFont;
  final Color backgroundColor;
  final Color textColor;
  final String selectedSize;
  final double fontScale;
  final int maxLines;
  final ExportFormat exportFormat;
  final int exportScale;
  final bool isExporting;

  const LogoState({
    this.selectedFont = 'Workbench',
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.selectedSize = '512 x 512',
    this.fontScale = 1.0,
    this.maxLines = 1,
    this.exportFormat = ExportFormat.png,
    this.exportScale = 1,
    this.isExporting = false,
  });

  LogoState copyWith({
    String? selectedFont,
    Color? backgroundColor,
    Color? textColor,
    String? selectedSize,
    double? fontScale,
    int? maxLines,
    ExportFormat? exportFormat,
    int? exportScale,
    bool? isExporting,
  }) {
    return LogoState(
      selectedFont: selectedFont ?? this.selectedFont,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      selectedSize: selectedSize ?? this.selectedSize,
      fontScale: fontScale ?? this.fontScale,
      maxLines: maxLines ?? this.maxLines,
      exportFormat: exportFormat ?? this.exportFormat,
      exportScale: exportScale ?? this.exportScale,
      isExporting: isExporting ?? this.isExporting,
    );
  }
}
