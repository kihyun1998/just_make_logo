import 'package:flutter/material.dart';

import '../theme/tweakcn_theme.g.dart';

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
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Row(
      children: [
        Icon(Icons.text_fields, size: 16, color: colors.mutedForeground),
        const SizedBox(width: 6),
        _buildButton(
          icon: Icons.remove,
          enabled: fontScale > 0.5,
          onTap: () => onChanged((fontScale - 0.1).clamp(0.5, 3.0)),
          colors: colors,
          radius: radius,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: colors.primary,
              inactiveTrackColor: colors.muted,
              thumbColor: colors.primary,
              overlayColor: colors.primary.withValues(alpha: 0.1),
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: fontScale,
              min: 0.5,
              max: 3.0,
              divisions: 25,
              onChanged: onChanged,
            ),
          ),
        ),
        _buildButton(
          icon: Icons.add,
          enabled: fontScale < 3.0,
          onTap: () => onChanged((fontScale + 0.1).clamp(0.5, 3.0)),
          colors: colors,
          radius: radius,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: colors.muted,
            borderRadius: BorderRadius.circular(radius.sm),
          ),
          child: Text(
            '${(fontScale * 100).round()}%',
            style: TextStyle(
              color: colors.foreground,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
    required TweakcnColors colors,
    required TweakcnRadius radius,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius.sm),
          border: Border.all(color: colors.border),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled ? colors.foreground : colors.muted,
        ),
      ),
    );
  }
}
