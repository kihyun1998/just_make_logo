import 'package:flutter/material.dart';

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
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        ...colors.map((color) {
          final isSelected = selected == color;
          return GestureDetector(
            onTap: () => onSelect(color),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey,
                  width: isSelected ? 2.5 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ],
    );
  }
}
