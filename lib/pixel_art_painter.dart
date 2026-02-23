import 'package:flutter/material.dart';
import 'pixel_font/pixel_font.dart';

class PixelArtPainter extends CustomPainter {
  final String text;

  PixelArtPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    if (text.isEmpty) return;

    final chars = text.split('');
    final totalWidth = chars.length * charWidth + (chars.length - 1) * charGap;

    final pixelW = size.width / totalWidth;
    final pixelH = size.height / charHeight;
    final pixelSize = pixelW < pixelH ? pixelW : pixelH;

    final gridPixelWidth = totalWidth * pixelSize;
    final gridPixelHeight = charHeight * pixelSize;
    final offsetX = (size.width - gridPixelWidth) / 2;
    final offsetY = (size.height - gridPixelHeight) / 2;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var cursorX = 0;
    for (final char in chars) {
      final glyph = pixelFont[char];
      if (glyph != null) {
        for (var row = 0; row < charHeight; row++) {
          for (var col = 0; col < charWidth; col++) {
            if (glyph[row][col] == 1) {
              canvas.drawRect(
                Rect.fromLTWH(
                  offsetX + (cursorX + col) * pixelSize,
                  offsetY + row * pixelSize,
                  pixelSize,
                  pixelSize,
                ),
                paint,
              );
            }
          }
        }
      }
      cursorX += charWidth + charGap;
    }
  }

  @override
  bool shouldRepaint(covariant PixelArtPainter oldDelegate) {
    return oldDelegate.text != text;
  }
}
