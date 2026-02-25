import 'package:flutter/material.dart';

import '../theme/tweakcn_theme.g.dart';

class LogoPreview extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double fontScale;
  final double aspectRatio;

  const LogoPreview({
    super.key,
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.fontScale,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;
    final shadows = context.tweakcnShadows;

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius.lg),
            border: Border.all(color: colors.border),
            boxShadow: shadows.shadowMd,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius.lg),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: (fontScale * 0.33).clamp(0.1, 1.0),
                heightFactor: (fontScale * 0.33).clamp(0.1, 1.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
