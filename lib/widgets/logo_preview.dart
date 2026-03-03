import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/logo_state.dart';
import '../theme/tweakcn_theme.g.dart';

class LogoPreview extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double textPadding;
  final double aspectRatio;
  final GlobalKey? repaintBoundaryKey;
  final Uint8List? imageBytes;
  final ImagePosition imagePosition;
  final double imageFlexRatio;
  final double imageGap;
  final ImageFitMode imageFitMode;

  const LogoPreview({
    super.key,
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.textPadding,
    required this.aspectRatio,
    this.repaintBoundaryKey,
    this.imageBytes,
    this.imagePosition = ImagePosition.top,
    this.imageFlexRatio = 0.5,
    this.imageGap = 8,
    this.imageFitMode = ImageFitMode.contain,
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
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Image.memory(
      imageBytes!,
      fit: _toBoxFit(imageFitMode),
    );
  }

  Widget _buildContent() {
    final hasImage = imageBytes != null;
    final hasText = text.isNotEmpty;

    // No image: original text-only layout
    if (!hasImage) {
      return _buildTextWidget();
    }

    // Image only, no text
    if (!hasText) {
      return Center(child: _buildImageWidget());
    }

    // Both image and text: flex layout
    final imageFlex = (imageFlexRatio * 100).round();
    final textFlex = 100 - imageFlex;
    final isVertical =
        imagePosition == ImagePosition.top || imagePosition == ImagePosition.bottom;

    final imageWidget = Expanded(
      flex: imageFlex,
      child: _buildImageWidget(),
    );
    final textWidget = Expanded(
      flex: textFlex,
      child: _buildTextWidget(),
    );
    final gap = SizedBox(
      width: isVertical ? null : imageGap,
      height: isVertical ? imageGap : null,
    );

    final children = imagePosition == ImagePosition.bottom ||
            imagePosition == ImagePosition.right
        ? [textWidget, gap, imageWidget]
        : [imageWidget, gap, textWidget];

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }

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
            borderRadius: BorderRadius.circular(radius.lg),
            border: Border.all(color: colors.border),
            boxShadow: shadows.shadowMd,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius.lg),
            child: RepaintBoundary(
              key: repaintBoundaryKey,
              child: Container(
                color: backgroundColor,
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
