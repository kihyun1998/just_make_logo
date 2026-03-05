import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/logo_state.dart';
import '../theme/tweakcn_theme.g.dart';

class LogoPreview extends StatelessWidget {
  final LogoMode logoMode;
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double canvasPadding;
  final double textPadding;
  final double aspectRatio;
  final GlobalKey? repaintBoundaryKey;
  final Uint8List? imageBytes;
  final String? svgString;
  final ImagePosition imagePosition;
  final double imageFlexRatio;
  final double imageGap;
  final ImageFitMode imageFitMode;
  final bool transparentBackground;
  final double exportBorderRadius;

  const LogoPreview({
    super.key,
    required this.logoMode,
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.canvasPadding,
    required this.textPadding,
    required this.aspectRatio,
    this.repaintBoundaryKey,
    this.imageBytes,
    this.svgString,
    this.imagePosition = ImagePosition.top,
    this.imageFlexRatio = 0.5,
    this.imageGap = 8,
    this.imageFitMode = ImageFitMode.contain,
    this.transparentBackground = false,
    this.exportBorderRadius = 0.0,
  });

  BoxFit _toBoxFit(ImageFitMode mode) {
    switch (mode) {
      case ImageFitMode.contain:
        return BoxFit.contain;
      case ImageFitMode.cover:
        return BoxFit.cover;
      case ImageFitMode.fill:
        return BoxFit.fill;
    }
  }

  Widget _buildTextWidget() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: (1.0 - textPadding).clamp(0.1, 1.0),
        heightFactor: (1.0 - textPadding).clamp(0.1, 1.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(text, style: textStyle, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Image.memory(imageBytes!, fit: _toBoxFit(imageFitMode));
  }

  Widget _buildContent() {
    final hasImage = imageBytes != null;

    // SVG only mode
    if (logoMode == LogoMode.svgOnly) {
      if (svgString == null) {
        return Center(
          child: Icon(
            Icons.data_object,
            size: 48,
            color: textStyle.color?.withValues(alpha: 0.3),
          ),
        );
      }
      return SizedBox.expand(
        child: SvgPicture.string(svgString!, fit: BoxFit.contain),
      );
    }

    // Text only mode
    if (logoMode == LogoMode.textOnly) {
      return _buildTextWidget();
    }

    // Image only mode
    if (logoMode == LogoMode.imageOnly) {
      if (!hasImage) {
        return Center(
          child: Icon(
            Icons.image_outlined,
            size: 48,
            color: textStyle.color?.withValues(alpha: 0.3),
          ),
        );
      }
      return SizedBox.expand(
        child: Image.memory(imageBytes!, fit: _toBoxFit(imageFitMode)),
      );
    }

    // Text + Image mode
    if (!hasImage) {
      return _buildTextWidget();
    }

    // Both image and text: flex layout
    final imageFlex = (imageFlexRatio * 100).round();
    final textFlex = 100 - imageFlex;
    final isVertical =
        imagePosition == ImagePosition.top ||
        imagePosition == ImagePosition.bottom;

    final imageWidget = Expanded(flex: imageFlex, child: _buildImageWidget());
    final textWidget = Expanded(flex: textFlex, child: _buildTextWidget());
    final gap = SizedBox(
      width: isVertical ? null : imageGap,
      height: isVertical ? imageGap : null,
    );

    final children =
        imagePosition == ImagePosition.bottom ||
            imagePosition == ImagePosition.right
        ? [textWidget, gap, imageWidget]
        : [imageWidget, gap, textWidget];

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }

  Widget _buildCheckerboard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const cellSize = 8.0;
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _CheckerboardPainter(cellSize: cellSize),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;
    final shadows = context.tweakcnShadows;

    final bgColor = transparentBackground
        ? Colors.transparent
        : backgroundColor;
    final hasBorderRadius = exportBorderRadius > 0;

    Widget innerContent = Container(
      color: bgColor,
      child: canvasPadding > 0
          ? Center(
              child: FractionallySizedBox(
                widthFactor: (1.0 - canvasPadding).clamp(0.1, 1.0),
                heightFactor: (1.0 - canvasPadding).clamp(0.1, 1.0),
                child: _buildContent(),
              ),
            )
          : _buildContent(),
    );

    if (hasBorderRadius) {
      innerContent = ClipRRect(
        borderRadius: BorderRadius.circular(exportBorderRadius),
        child: innerContent,
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.lg),
            border: Border.all(color: colors.border),
            boxShadow: shadows.shadowMd,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius.lg),
            child: Stack(
              children: [
                if (transparentBackground) _buildCheckerboard(),
                RepaintBoundary(key: repaintBoundaryKey, child: innerContent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  final double cellSize;
  _CheckerboardPainter({required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final light = Paint()..color = Colors.white;
    final dark = Paint()..color = const Color(0xFFE0E0E0);

    for (double y = 0; y < size.height; y += cellSize) {
      for (double x = 0; x < size.width; x += cellSize) {
        final isEven = ((x ~/ cellSize) + (y ~/ cellSize)) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          isEven ? light : dark,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
