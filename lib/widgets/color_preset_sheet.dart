import 'package:flutter/material.dart';

import '../models/color_preset.dart';
import '../theme/tweakcn_theme.g.dart';

class ColorPresetSheet extends StatelessWidget {
  final List<ColorPreset> presets;
  final ValueChanged<ColorPreset> onApply;
  final ValueChanged<String> onDelete;
  final void Function(String id, String newName) onRename;

  const ColorPresetSheet({
    super.key,
    required this.presets,
    required this.onApply,
    required this.onDelete,
    required this.onRename,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius.lg)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
            child: Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  size: 18,
                  color: colors.foreground,
                ),
                const SizedBox(width: 8),
                Text(
                  'Saved Colors',
                  style: TextStyle(
                    color: colors.foreground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 20, color: colors.foreground),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.border),
          // List
          if (presets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No saved presets',
                style: TextStyle(color: colors.mutedForeground, fontSize: 14),
              ),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: presets.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final preset = presets[index];
                  return _ColorPresetTile(
                    preset: preset,
                    onApply: () {
                      onApply(preset);
                      Navigator.pop(context);
                    },
                    onRename: () => _showRenameDialog(context, preset),
                    onDelete: () async {
                      final confirmed = await _showDeleteConfirmDialog(
                        context,
                        preset,
                      );
                      if (confirmed) onDelete(preset.id);
                    },
                  );
                },
              ),
            ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context, ColorPreset preset) {
    final controller = TextEditingController(text: preset.name);
    final colors = context.tweakcnColors;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.card,
        title: Text(
          'Rename Preset',
          style: TextStyle(color: colors.foreground, fontSize: 16),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: colors.foreground),
          decoration: InputDecoration(
            hintText: 'New name',
            hintStyle: TextStyle(color: colors.mutedForeground),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.ring),
            ),
          ),
          onSubmitted: (value) {
            final name = value.trim();
            if (name.isNotEmpty) {
              onRename(preset.id, name);
            }
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: colors.mutedForeground),
            ),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                onRename(preset.id, name);
              }
              Navigator.pop(ctx);
            },
            child: Text('Save', style: TextStyle(color: colors.primary)),
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmDialog(
    BuildContext context,
    ColorPreset preset,
  ) async {
    final colors = context.tweakcnColors;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.card,
        title: Text(
          'Delete Preset',
          style: TextStyle(color: colors.foreground, fontSize: 16),
        ),
        content: Text(
          "'${preset.name}' will be permanently deleted.",
          style: TextStyle(color: colors.mutedForeground, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: colors.mutedForeground),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: TextStyle(color: colors.destructive)),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _ColorPresetTile extends StatelessWidget {
  final ColorPreset preset;
  final VoidCallback onApply;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  const _ColorPresetTile({
    required this.preset,
    required this.onApply,
    required this.onRename,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.tweakcnColors;

    return InkWell(
      onTap: onApply,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 8, top: 6, bottom: 6),
        child: Row(
          children: [
            CustomPaint(
              size: const Size(32, 32),
              painter: _HalfCirclePainter(
                leftColor: preset.backgroundColor,
                rightColor: preset.textColor,
                borderColor: colors.border,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                preset.name,
                style: TextStyle(
                  color: colors.foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: onRename,
              icon: Icon(
                Icons.edit_outlined,
                size: 18,
                color: colors.mutedForeground,
              ),
              tooltip: 'Rename',
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                size: 18,
                color: colors.destructive,
              ),
              tooltip: 'Delete',
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final Color leftColor;
  final Color rightColor;
  final Color borderColor;

  _HalfCirclePainter({
    required this.leftColor,
    required this.rightColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Left half (background color)
    canvas.drawArc(
      rect,
      1.5708, // 90° (pi/2)
      3.1416, // 180° (pi)
      true,
      Paint()..color = leftColor,
    );

    // Right half (text color)
    canvas.drawArc(
      rect,
      -1.5708, // -90°
      3.1416, // 180°
      true,
      Paint()..color = rightColor,
    );

    // Border
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(covariant _HalfCirclePainter oldDelegate) =>
      leftColor != oldDelegate.leftColor ||
      rightColor != oldDelegate.rightColor ||
      borderColor != oldDelegate.borderColor;
}
