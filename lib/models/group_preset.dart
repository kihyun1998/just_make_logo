import 'size_preset.dart';

class GroupPreset {
  final String label;
  final IconLabel icon;
  final List<SizePreset> sizes;

  const GroupPreset({
    required this.label,
    required this.icon,
    required this.sizes,
  });
}

enum IconLabel { android, apple, web, windows }
