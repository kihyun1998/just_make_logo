import 'package:flutter/material.dart';
import 'package:just_color_picker/just_color_picker.dart';

import '../theme/tweakcn_theme.g.dart';

class ColorPicker extends StatelessWidget {
  final String label;
  final Color selected;
  final List<Color> colors;
  final ValueChanged<Color> onSelect;

  const ColorPicker({
    super.key,
    required this.label,
    required this.selected,
    required this.colors,
    required this.onSelect,
  });

  void _showColorPickerDialog(BuildContext context) {
    Color pickedColor = selected;
    final tc = context.tweakcnColors;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: tc.card,
        title: Text(
          '$label Color',
          style: TextStyle(color: tc.foreground, fontSize: 16),
        ),
        content: JustColorPicker(
          color: pickedColor,
          type: ColorPickerType.bar,
          showAlpha: false,
          onColorChanged: (color) {
            pickedColor = color;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: tc.mutedForeground)),
          ),
          TextButton(
            onPressed: () {
              onSelect(pickedColor);
              Navigator.pop(ctx);
            },
            child: Text('Apply', style: TextStyle(color: tc.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tc = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36,
          child: Text(
            label,
            style: TextStyle(
              color: tc.mutedForeground,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...colors.map((color) {
                final isSelected = selected == color;
                return GestureDetector(
                  onTap: () => onSelect(color),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isSelected ? tc.ring : tc.border,
                        width: isSelected ? 2.0 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radius.sm),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 14,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black87
                                : Colors.white,
                          )
                        : null,
                  ),
                );
              }),
              // Custom color picker button
              Builder(
                builder: (context) {
                  final isCustom = !colors.contains(selected);
                  return GestureDetector(
                    onTap: () => _showColorPickerDialog(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: isCustom ? selected : null,
                        border: Border.all(
                          color: isCustom ? tc.ring : tc.border,
                          width: isCustom ? 2.0 : 1,
                        ),
                        borderRadius: BorderRadius.circular(radius.sm),
                      ),
                      child: Icon(
                        isCustom ? Icons.check : Icons.add,
                        size: isCustom ? 14 : 16,
                        color: isCustom
                            ? (selected.computeLuminance() > 0.5
                                  ? Colors.black87
                                  : Colors.white)
                            : tc.mutedForeground,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
