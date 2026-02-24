import 'package:flutter/material.dart';

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
    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: (fontScale * 0.33).clamp(0.1, 1.0),
                heightFactor: (fontScale * 0.33).clamp(0.1, 1.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(text, style: textStyle),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
