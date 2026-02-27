import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

enum ExportFormat { png, jpg, svg }

class ExportUtils {
  static Future<ui.Image> _captureImage(
    GlobalKey repaintKey, {
    required int targetWidth,
    required int scale,
  }) async {
    final boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final renderedWidth = boundary.size.width;
    final pixelRatio = (targetWidth * scale) / renderedWidth;
    return boundary.toImage(pixelRatio: pixelRatio);
  }

  static Future<Uint8List> _toPng(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static Future<Uint8List> _toJpg(ui.Image image, {int quality = 95}) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final imgImage = img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: byteData!.buffer,
      order: img.ChannelOrder.rgba,
    );
    return Uint8List.fromList(img.encodeJpg(imgImage, quality: quality));
  }

  static String _toSvg({
    required String text,
    required int width,
    required int height,
    required Color backgroundColor,
    required Color textColor,
    required String fontFamily,
    required double fontScale,
  }) {
    final bgHex = _colorToHex(backgroundColor);
    final textHex = _colorToHex(textColor);

    final lines = text.split('\n');
    final lineCount = lines.length;
    final maxChars = lines
        .map((l) => l.length)
        .reduce((a, b) => a > b ? a : b)
        .clamp(1, 999);

    final scaleFactor = (fontScale * 0.33).clamp(0.1, 1.0);
    final availableWidth = width * scaleFactor;
    final availableHeight = height * scaleFactor;

    final byWidth = availableWidth / (maxChars * 0.6);
    final byHeight = availableHeight / (lineCount * 1.2);
    final fontSize = byWidth < byHeight ? byWidth : byHeight;

    final lineHeight = fontSize * 1.2;
    final totalTextHeight = lineHeight * lineCount;
    final startY = (height - totalTextHeight) / 2 + fontSize * 0.85;

    // Google Fonts URL for embedding
    final fontParam = fontFamily.replaceAll(' ', '+');
    final fontUrl = 'https://fonts.googleapis.com/css2?family=$fontParam';

    final textElements = lines
        .asMap()
        .entries
        .map((entry) {
          final y = startY + entry.key * lineHeight;
          return '  <text x="${width / 2}" y="${y.toStringAsFixed(1)}" '
              'text-anchor="middle" '
              'font-family="\'$fontFamily\', sans-serif" '
              'font-size="${fontSize.toStringAsFixed(1)}" '
              'fill="$textHex">${_escapeXml(entry.value)}</text>';
        })
        .join('\n');

    return '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height" viewBox="0 0 $width $height">\n'
        '  <defs>\n'
        '    <style>\n'
        '      @import url(\'$fontUrl\');\n'
        '    </style>\n'
        '  </defs>\n'
        '  <rect width="$width" height="$height" fill="$bgHex"/>\n'
        '$textElements\n'
        '</svg>';
  }

  static String _colorToHex(Color color) {
    final value = color.toARGB32();
    final r = (value >> 16) & 0xFF;
    final g = (value >> 8) & 0xFF;
    final b = value & 0xFF;
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  static String _escapeXml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }

  /// Main export method. Returns true if export was successful.
  static Future<bool> export({
    required GlobalKey repaintKey,
    required ExportFormat format,
    required int targetWidth,
    required int targetHeight,
    required int scale,
    // For SVG
    String? text,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
    double? fontScale,
  }) async {
    final ext = format.name;
    final scaleLabel = (format != ExportFormat.svg && scale > 1)
        ? '@${scale}x'
        : '';
    final fileName = 'logo_${targetWidth}x$targetHeight$scaleLabel.$ext';

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Logo',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: [ext],
    );

    if (result == null) return false;

    String filePath = result;
    if (!filePath.toLowerCase().endsWith('.$ext')) {
      filePath = '$filePath.$ext';
    }

    final file = File(filePath);

    switch (format) {
      case ExportFormat.png:
        final image = await _captureImage(
          repaintKey,
          targetWidth: targetWidth,
          scale: scale,
        );
        final bytes = await _toPng(image);
        await file.writeAsBytes(bytes);
      case ExportFormat.jpg:
        final image = await _captureImage(
          repaintKey,
          targetWidth: targetWidth,
          scale: scale,
        );
        final bytes = await _toJpg(image);
        await file.writeAsBytes(bytes);
      case ExportFormat.svg:
        final svgContent = _toSvg(
          text: text!,
          width: targetWidth,
          height: targetHeight,
          backgroundColor: backgroundColor!,
          textColor: textColor!,
          fontFamily: fontFamily!,
          fontScale: fontScale!,
        );
        await file.writeAsString(svgContent);
    }

    return true;
  }
}
