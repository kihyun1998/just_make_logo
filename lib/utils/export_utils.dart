import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

import '../models/logo_state.dart';

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
    required double canvasPadding,
    required double textPadding,
    required BackgroundShape backgroundShape,
    required double borderRadius,
    required bool transparentBackground,
    required int fontWeightValue,
  }) {
    final bgHex = _colorToHex(backgroundColor);
    final textHex = _colorToHex(textColor);

    final lines = text.split('\n');
    final lineCount = lines.length;
    final maxChars = lines
        .map((l) => l.length)
        .reduce((a, b) => a > b ? a : b)
        .clamp(1, 999);

    final canvasScale = (1.0 - canvasPadding).clamp(0.1, 1.0);
    final textScale = (1.0 - textPadding).clamp(0.1, 1.0);
    final availableWidth = width * canvasScale * textScale;
    final availableHeight = height * canvasScale * textScale;

    final byWidth = availableWidth / (maxChars * 0.6);
    final byHeight = availableHeight / (lineCount * 1.2);
    final fontSize = byWidth < byHeight ? byWidth : byHeight;

    final lineHeight = fontSize * 1.2;
    final totalTextHeight = lineHeight * lineCount;
    final startY = (height - totalTextHeight) / 2 + fontSize * 0.85;

    // Google Fonts URL for embedding
    final fontParam = fontFamily.replaceAll(' ', '+');
    final fontUrl =
        'https://fonts.googleapis.com/css2?family=$fontParam:wght@$fontWeightValue';

    final textElements = lines
        .asMap()
        .entries
        .map((entry) {
          final y = startY + entry.key * lineHeight;
          return '  <text x="${width / 2}" y="${y.toStringAsFixed(1)}" '
              'text-anchor="middle" '
              'font-family="\'$fontFamily\', sans-serif" '
              'font-size="${fontSize.toStringAsFixed(1)}" '
              'font-weight="$fontWeightValue" '
              'fill="$textHex">${_escapeXml(entry.value)}</text>';
        })
        .join('\n');

    final isCircle = backgroundShape == BackgroundShape.circle;
    final cx = width / 2;
    final cy = height / 2;
    final r = (width < height ? width : height) / 2;

    String bgElement = '';
    if (!transparentBackground) {
      if (isCircle) {
        bgElement = '  <circle cx="$cx" cy="$cy" r="$r" fill="$bgHex"/>\n';
      } else if (borderRadius > 0) {
        bgElement =
            '  <rect width="$width" height="$height" rx="$borderRadius" ry="$borderRadius" fill="$bgHex"/>\n';
      } else {
        bgElement =
            '  <rect width="$width" height="$height" fill="$bgHex"/>\n';
      }
    }

    final needsClip = isCircle || borderRadius > 0;
    String clipOpen = '';
    String clipClose = '';
    String clipDefs = '';
    if (needsClip) {
      final clipShape = isCircle
          ? '      <circle cx="$cx" cy="$cy" r="$r"/>'
          : '      <rect width="$width" height="$height" rx="$borderRadius" ry="$borderRadius"/>';
      clipDefs = '    <clipPath id="clip">\n$clipShape\n    </clipPath>\n';
      clipOpen = '  <g clip-path="url(#clip)">\n';
      clipClose = '  </g>\n';
    }

    return '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height" viewBox="0 0 $width $height">\n'
        '  <defs>\n'
        '    <style>\n'
        '      @import url(\'$fontUrl\');\n'
        '    </style>\n'
        '$clipDefs'
        '  </defs>\n'
        '$bgElement'
        '$clipOpen'
        '$textElements\n'
        '$clipClose'
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

  static String _wrapSvg({
    required String innerSvg,
    required int width,
    required int height,
    required Color backgroundColor,
    required double canvasPadding,
    required double borderRadius,
    required bool transparentBackground,
    required BackgroundShape backgroundShape,
  }) {
    final scale = (1.0 - canvasPadding).clamp(0.1, 1.0);
    final innerW = (width * scale).round();
    final innerH = (height * scale).round();
    final x = ((width - innerW) / 2).round();
    final y = ((height - innerH) / 2).round();

    final buf = StringBuffer();
    buf.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buf.writeln(
      '<svg xmlns="http://www.w3.org/2000/svg" '
      'xmlns:xlink="http://www.w3.org/1999/xlink" '
      'width="$width" height="$height" '
      'viewBox="0 0 $width $height">',
    );

    final isCircle = backgroundShape == BackgroundShape.circle;
    final cx = width / 2;
    final cy = height / 2;
    final r = (width < height ? width : height) / 2;

    // Background
    if (!transparentBackground) {
      final bgHex = _colorToHex(backgroundColor);
      if (isCircle) {
        buf.writeln(
          '  <circle cx="$cx" cy="$cy" r="$r" fill="$bgHex"/>',
        );
      } else if (borderRadius > 0) {
        buf.writeln(
          '  <rect width="$width" height="$height" '
          'rx="$borderRadius" ry="$borderRadius" fill="$bgHex"/>',
        );
      } else {
        buf.writeln('  <rect width="$width" height="$height" fill="$bgHex"/>');
      }
    }

    // Clip with shape
    final needsClip = isCircle || borderRadius > 0;
    if (needsClip) {
      buf.writeln('  <defs>');
      buf.writeln('    <clipPath id="clip">');
      if (isCircle) {
        buf.writeln('      <circle cx="$cx" cy="$cy" r="$r"/>');
      } else {
        buf.writeln(
          '      <rect width="$width" height="$height" '
          'rx="$borderRadius" ry="$borderRadius"/>',
        );
      }
      buf.writeln('    </clipPath>');
      buf.writeln('  </defs>');
      buf.writeln('  <g clip-path="url(#clip)">');
    }

    // Inner SVG centered with padding — preserve original attributes (viewBox, fill, etc.)
    var inner = innerSvg.replaceAll(RegExp(r'<\?xml[^?]*\?>'), '').trim();
    // Replace width/height/x/y on the original <svg> tag
    inner = inner.replaceFirst(RegExp(r'<svg\b'), '<svg x="$x" y="$y"');
    inner = inner.replaceAll(RegExp(r'\s*width="[^"]*"'), ' width="$innerW"');
    inner = inner.replaceAll(RegExp(r'\s*height="[^"]*"'), ' height="$innerH"');
    buf.writeln(inner);

    if (needsClip) {
      buf.writeln('  </g>');
    }

    buf.writeln('</svg>');
    return buf.toString();
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
    // For SVG (text mode)
    String? text,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
    double? canvasPadding,
    double? textPadding,
    // For SVG (svg upload mode)
    String? svgString,
    double? borderRadius,
    bool? transparentBg,
    BackgroundShape? backgroundShape,
    int? fontWeightValue,
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
        final String svgContent;
        if (svgString != null) {
          svgContent = _wrapSvg(
            innerSvg: svgString,
            width: targetWidth,
            height: targetHeight,
            backgroundColor: backgroundColor!,
            canvasPadding: canvasPadding ?? 0.0,
            borderRadius: borderRadius ?? 0.0,
            transparentBackground: transparentBg ?? false,
            backgroundShape: backgroundShape ?? BackgroundShape.rectangle,
          );
        } else {
          svgContent = _toSvg(
            text: text!,
            width: targetWidth,
            height: targetHeight,
            backgroundColor: backgroundColor!,
            textColor: textColor!,
            fontFamily: fontFamily!,
            canvasPadding: canvasPadding!,
            textPadding: textPadding!,
            backgroundShape: backgroundShape ?? BackgroundShape.rectangle,
            borderRadius: borderRadius ?? 0.0,
            transparentBackground: transparentBg ?? false,
            fontWeightValue: fontWeightValue ?? 400,
          );
        }
        await file.writeAsString(svgContent);
    }

    return true;
  }

  /// Batch export multiple sizes to a selected folder.
  /// Returns the number of successfully exported files.
  static Future<int> exportGroup({
    required GlobalKey repaintKey,
    required ExportFormat format,
    required List<({String name, int width, int height})> sizes,
    required int scale,
    // For SVG (text mode)
    String? text,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
    double? canvasPadding,
    double? textPadding,
    // For SVG (svg upload mode)
    String? svgString,
    double? borderRadius,
    bool? transparentBg,
    BackgroundShape? backgroundShape,
    int? fontWeightValue,
  }) async {
    final dirPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select folder to save logos',
    );
    if (dirPath == null) return 0;

    final ext = format.name;
    int count = 0;

    for (final size in sizes) {
      final scaleLabel =
          (format != ExportFormat.svg && scale > 1) ? '@${scale}x' : '';
      final fileName = '${size.name}$scaleLabel.$ext';
      final file = File('$dirPath/$fileName');

      switch (format) {
        case ExportFormat.png:
          final image = await _captureImage(
            repaintKey,
            targetWidth: size.width,
            scale: scale,
          );
          final bytes = await _toPng(image);
          await file.writeAsBytes(bytes);
          count++;
        case ExportFormat.jpg:
          final image = await _captureImage(
            repaintKey,
            targetWidth: size.width,
            scale: scale,
          );
          final bytes = await _toJpg(image);
          await file.writeAsBytes(bytes);
          count++;
        case ExportFormat.svg:
          final String svgContent;
          if (svgString != null) {
            svgContent = _wrapSvg(
              innerSvg: svgString,
              width: size.width,
              height: size.height,
              backgroundColor: backgroundColor!,
              canvasPadding: canvasPadding ?? 0.0,
              borderRadius: borderRadius ?? 0.0,
              transparentBackground: transparentBg ?? false,
              backgroundShape: backgroundShape ?? BackgroundShape.rectangle,
            );
          } else {
            svgContent = _toSvg(
              text: text!,
              width: size.width,
              height: size.height,
              backgroundColor: backgroundColor!,
              textColor: textColor!,
              fontFamily: fontFamily!,
              canvasPadding: canvasPadding!,
              textPadding: textPadding!,
              backgroundShape: backgroundShape ?? BackgroundShape.rectangle,
              borderRadius: borderRadius ?? 0.0,
              transparentBackground: transparentBg ?? false,
              fontWeightValue: fontWeightValue ?? 400,
            );
          }
          await file.writeAsString(svgContent);
          count++;
      }
    }

    return count;
  }
}
