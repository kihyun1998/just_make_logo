import 'package:flutter/material.dart';

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
            children: colors.map((color) {
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
            }).toList(),
          ),
        ),
      ],
    );
  }
}
