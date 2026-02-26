import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
