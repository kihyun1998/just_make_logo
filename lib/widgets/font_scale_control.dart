import 'package:flutter/material.dart';

class FontScaleControl extends StatelessWidget {
  final double fontScale;
  final ValueChanged<double> onChanged;

  const FontScaleControl({
    super.key,
    required this.fontScale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 80, child: Text('Font Size')),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: fontScale > 0.5
              ? () => onChanged((fontScale - 0.1).clamp(0.5, 3.0))
              : null,
        ),
        Expanded(
          child: Slider(
            value: fontScale,
            min: 0.5,
            max: 3.0,
            divisions: 25,
            label: '${(fontScale * 100).round()}%',
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: fontScale < 3.0
              ? () => onChanged((fontScale + 0.1).clamp(0.5, 3.0))
              : null,
        ),
        SizedBox(
          width: 48,
          child: Text(
            '${(fontScale * 100).round()}%',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
