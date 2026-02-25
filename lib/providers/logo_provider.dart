import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/logo_state.dart';
import '../utils/export_utils.dart';

part 'logo_provider.g.dart';

@Riverpod(keepAlive: true)
class LogoNotifier extends _$LogoNotifier {
  @override
  LogoState build() => const LogoState();

  void setFont(String font) {
    state = state.copyWith(selectedFont: font);
  }

  void setBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }

  void setTextColor(Color color) {
    state = state.copyWith(textColor: color);
  }

  void setSelectedSize(String size) {
    state = state.copyWith(selectedSize: size);
  }

  void setFontScale(double scale) {
    state = state.copyWith(fontScale: scale);
  }

  void setMaxLines(int lines) {
    state = state.copyWith(maxLines: lines);
  }

  void setExportFormat(ExportFormat format) {
    if (format == ExportFormat.svg) {
      state = state.copyWith(exportFormat: format, exportScale: 1);
    } else {
      state = state.copyWith(exportFormat: format);
    }
  }

  void setExportScale(int scale) {
    state = state.copyWith(exportScale: scale);
  }

  void setIsExporting(bool value) {
    state = state.copyWith(isExporting: value);
  }
}
