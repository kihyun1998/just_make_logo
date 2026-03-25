import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/logo_constants.dart';
import '../models/color_preset.dart';
import '../models/logo_state.dart';
import '../utils/export_utils.dart';
import 'theme_provider.dart';

part 'logo_provider.g.dart';

const _kColorPresetsKey = 'color_presets';

@Riverpod(keepAlive: true)
class LogoNotifier extends _$LogoNotifier {
  @override
  LogoState build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getStringList(_kColorPresetsKey) ?? [];
    final presets = saved.map((s) => ColorPreset.decode(s)).toList();
    return LogoState(colorPresets: presets);
  }

  void saveColorPreset(String name) {
    final preset = ColorPreset(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      backgroundColor: state.backgroundColor,
      textColor: state.textColor,
    );
    final updated = [...state.colorPresets, preset];
    state = state.copyWith(colorPresets: updated);
    _persistColorPresets(updated);
  }

  void applyColorPreset(ColorPreset preset) {
    state = state.copyWith(
      backgroundColor: preset.backgroundColor,
      textColor: preset.textColor,
    );
  }

  void renameColorPreset(String id, String newName) {
    final updated = state.colorPresets.map((p) {
      if (p.id == id) {
        return ColorPreset(
          id: p.id,
          name: newName,
          backgroundColor: p.backgroundColor,
          textColor: p.textColor,
        );
      }
      return p;
    }).toList();
    state = state.copyWith(colorPresets: updated);
    _persistColorPresets(updated);
  }

  void deleteColorPreset(String id) {
    final updated = state.colorPresets.where((p) => p.id != id).toList();
    state = state.copyWith(colorPresets: updated);
    _persistColorPresets(updated);
  }

  void _persistColorPresets(List<ColorPreset> presets) {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList(
      _kColorPresetsKey,
      presets.map((p) => p.encode()).toList(),
    );
  }

  void setLogoMode(LogoMode mode) {
    state = state.copyWith(logoMode: mode);
    // SVG export only allowed for textOnly and svgOnly
    if (mode != LogoMode.textOnly &&
        mode != LogoMode.svgOnly &&
        state.exportFormat == ExportFormat.svg) {
      state = state.copyWith(exportFormat: ExportFormat.png);
    }
  }

  void setFont(String font) {
    final available = LogoConstants.fontWeights[font] ?? [400];
    final currentWeight = state.fontWeightValue;
    final newWeight =
        available.contains(currentWeight) ? currentWeight : available.first;
    state = state.copyWith(selectedFont: font, fontWeightValue: newWeight);
  }

  void setFontWeight(int value) {
    state = state.copyWith(fontWeightValue: value);
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

  void setCanvasPadding(double padding) {
    state = state.copyWith(canvasPadding: padding);
  }

  void setTextPadding(double padding) {
    state = state.copyWith(textPadding: padding);
  }

  void setMaxLines(int lines) {
    state = state.copyWith(maxLines: lines);
  }

  void setExportFormat(ExportFormat format) {
    if (format == ExportFormat.svg &&
        state.logoMode != LogoMode.textOnly &&
        state.logoMode != LogoMode.svgOnly) {
      return;
    }
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

  void setImageBytes(Uint8List? bytes) {
    state = state.copyWith(imageBytes: bytes);
  }

  void setImagePosition(ImagePosition pos) {
    state = state.copyWith(imagePosition: pos);
  }

  void setImageFlexRatio(double ratio) {
    state = state.copyWith(imageFlexRatio: ratio.clamp(0.1, 0.9));
  }

  void setImageGap(double gap) {
    state = state.copyWith(imageGap: gap.clamp(0, 50));
  }

  void setImageFitMode(ImageFitMode mode) {
    state = state.copyWith(imageFitMode: mode);
  }

  void setTransparentBackground(bool value) {
    state = state.copyWith(transparentBackground: value);
  }

  void setExportBorderRadius(double radius) {
    state = state.copyWith(exportBorderRadius: radius.clamp(0, 100));
  }

  void setBackgroundShape(BackgroundShape shape) {
    state = state.copyWith(backgroundShape: shape);
  }

  void setUseGradient(bool value) {
    state = state.copyWith(useGradient: value);
  }

  void setGradientEndColor(Color color) {
    state = state.copyWith(gradientEndColor: color);
  }

  void setGradientType(GradientType type) {
    state = state.copyWith(gradientType: type);
  }

  void setGradientDirection(GradientDirection direction) {
    state = state.copyWith(gradientDirection: direction);
  }

  void applyGradientPreset(GradientPreset preset) {
    state = state.copyWith(
      useGradient: true,
      backgroundColor: preset.startColor,
      gradientEndColor: preset.endColor,
      gradientType: preset.type,
      gradientDirection: preset.direction,
    );
  }

  void setSvgString(String? svg) {
    state = state.copyWith(svgString: svg);
  }

  void clearSvg() {
    state = state.copyWith(svgString: null);
  }

  void clearImage() {
    state = state.copyWith(imageBytes: null);
  }

  Future<bool> savePreset(String text) async {
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Preset',
      fileName: 'logo_preset.json',
      allowedExtensions: ['json'],
      type: FileType.custom,
    );
    if (result == null) return false;

    final json = state.toPresetJson(text);
    final file = File(result);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(json),
    );
    return true;
  }

  Future<String?> loadPreset() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Load Preset',
      allowedExtensions: ['json'],
      type: FileType.custom,
    );
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    final preset = LogoState.fromPresetJson(json);

    state = preset.state.copyWith(
      colorPresets: state.colorPresets,
      imageBytes: state.imageBytes,
      svgString: state.svgString,
    );
    return preset.text;
  }
}
