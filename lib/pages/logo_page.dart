import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_button/flutter_dropdown_button.dart';

import '../constants/logo_constants.dart';
import '../theme/tweakcn_theme.g.dart';
import '../utils/export_utils.dart';
import '../utils/font_installer.dart';
import '../utils/font_utils.dart';
import '../widgets/color_picker.dart';
import '../widgets/font_scale_control.dart';
import '../widgets/logo_preview.dart';

class LogoPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const LogoPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  final TextEditingController _controller = TextEditingController(
    text: 'HELLO',
  );
  final TextEditingController _widthController = TextEditingController(
    text: '512',
  );
  final TextEditingController _heightController = TextEditingController(
    text: '512',
  );

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  String _selectedFont = 'Workbench';
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  String _selectedSize = '512 x 512';
  double _fontScale = 1.0;
  int _maxLines = 1;

  ExportFormat _exportFormat = ExportFormat.png;
  int _exportScale = 1;
  bool _isExporting = false;

  bool get _isCustomSize => _selectedSize == 'Custom';

  int get _logoWidth {
    if (_isCustomSize) return int.tryParse(_widthController.text) ?? 512;
    return LogoConstants.sizePresets
        .firstWhere((p) => p.label == _selectedSize)
        .width;
  }

  int get _logoHeight {
    if (_isCustomSize) return int.tryParse(_heightController.text) ?? 512;
    return LogoConstants.sizePresets
        .firstWhere((p) => p.label == _selectedSize)
        .height;
  }

  @override
  void dispose() {
    _controller.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colors.mutedForeground, fontSize: 13),
      filled: true,
      fillColor: colors.muted,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.md),
        borderSide: BorderSide(color: colors.input),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.md),
        borderSide: BorderSide(color: colors.input),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.md),
        borderSide: BorderSide(color: colors.ring, width: 1.5),
      ),
      isDense: true,
    );
  }

  Widget _buildSectionLabel(String text, IconData icon) {
    final colors = context.tweakcnColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: colors.mutedForeground),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: colors.mutedForeground,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewPanel() {
    final aspectRatio = _logoWidth / _logoHeight;
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(radius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          // Size badge
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              color: colors.muted,
              borderRadius: BorderRadius.circular(radius.sm),
            ),
            child: Text(
              '$_logoWidth  x  $_logoHeight',
              style: TextStyle(
                color: colors.mutedForeground,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Preview
          Expanded(
            child: LogoPreview(
              text: _controller.text,
              textStyle: getFontStyle(_selectedFont, 120, _textColor),
              backgroundColor: _backgroundColor,
              fontScale: _fontScale,
              aspectRatio: aspectRatio,
              repaintBoundaryKey: _repaintBoundaryKey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(radius.lg),
        border: Border.all(color: colors.border),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text input
            _buildSectionLabel('TEXT', Icons.text_fields),
            TextField(
              controller: _controller,
              style: TextStyle(color: colors.foreground, fontSize: 15),
              decoration: _inputDecoration('Enter text'),
              maxLines: _maxLines,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 6),
            // Line count
            Row(
              children: [
                Text('Lines',
                    style: TextStyle(
                        color: colors.mutedForeground, fontSize: 12)),
                const SizedBox(width: 8),
                ...List.generate(3, (i) {
                  final n = i + 1;
                  final isSelected = _maxLines == n;
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: () => setState(() => _maxLines = n),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radius.sm),
                          border: isSelected
                              ? null
                              : Border.all(color: colors.border),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$n',
                          style: TextStyle(
                            color: isSelected
                                ? colors.primaryForeground
                                : colors.mutedForeground,
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            _buildDivider(),

            // Font
            _buildSectionLabel('FONT', Icons.font_download_outlined),
            Row(
              children: [
                Expanded(
                  child: TextOnlyDropdownButton(
                    items: LogoConstants.fonts,
                    value: _selectedFont,
                    hint: 'Font',
                    width: double.infinity,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedFont = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    onPressed: _handleFontInstall,
                    icon: Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: colors.mutedForeground,
                    ),
                    tooltip: 'Download font from Google Fonts',
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius.sm),
                        side: BorderSide(color: colors.border),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            _buildDivider(),

            // Size
            _buildSectionLabel('SIZE', Icons.aspect_ratio),
            TextOnlyDropdownButton(
              items:
                  LogoConstants.sizePresets.map((p) => p.label).toList(),
              value: _selectedSize,
              hint: 'Size',
              width: double.infinity,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedSize = value;
                    if (!_isCustomSize) {
                      final preset =
                          LogoConstants.sizePresets.firstWhere(
                        (p) => p.label == value,
                      );
                      _widthController.text = preset.width.toString();
                      _heightController.text = preset.height.toString();
                    }
                  });
                }
              },
            ),
            if (_isCustomSize) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _widthController,
                      style: TextStyle(
                          color: colors.foreground, fontSize: 14),
                      decoration: _inputDecoration('W'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.close,
                        size: 12, color: colors.mutedForeground),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _heightController,
                      style: TextStyle(
                          color: colors.foreground, fontSize: 14),
                      decoration: _inputDecoration('H'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ],

            _buildDivider(),

            // Font scale
            _buildSectionLabel('SCALE', Icons.zoom_in),
            FontScaleControl(
              fontScale: _fontScale,
              onChanged: (v) => setState(() => _fontScale = v),
            ),

            _buildDivider(),

            // Colors
            _buildSectionLabel('COLORS', Icons.palette_outlined),
            ColorPicker(
              label: 'BG',
              selected: _backgroundColor,
              colors: LogoConstants.colors,
              onSelect: (c) => setState(() => _backgroundColor = c),
            ),
            const SizedBox(height: 8),
            ColorPicker(
              label: 'Text',
              selected: _textColor,
              colors: LogoConstants.colors,
              onSelect: (c) => setState(() => _textColor = c),
            ),

            _buildDivider(),

            // Export
            _buildSectionLabel('EXPORT', Icons.download_outlined),
            // Format selector
            Row(
              children: [
                Text(
                  'Format',
                  style: TextStyle(
                    color: colors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                _buildOptionChip(
                  'PNG',
                  isSelected: _exportFormat == ExportFormat.png,
                  onTap: () =>
                      setState(() => _exportFormat = ExportFormat.png),
                ),
                _buildOptionChip(
                  'JPG',
                  isSelected: _exportFormat == ExportFormat.jpg,
                  onTap: () =>
                      setState(() => _exportFormat = ExportFormat.jpg),
                ),
                _buildOptionChip(
                  'SVG',
                  isSelected: _exportFormat == ExportFormat.svg,
                  onTap: () => setState(() {
                    _exportFormat = ExportFormat.svg;
                    _exportScale = 1;
                  }),
                ),
              ],
            ),
            // Scale selector (raster only)
            if (_exportFormat != ExportFormat.svg) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Scale',
                    style: TextStyle(
                      color: colors.mutedForeground,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  for (final s in [1, 2, 3, 4])
                    _buildOptionChip(
                      'x$s',
                      isSelected: _exportScale == s,
                      onTap: () => setState(() => _exportScale = s),
                    ),
                ],
              ),
            ],
            // Output dimensions
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: colors.muted,
                borderRadius: BorderRadius.circular(radius.sm),
              ),
              child: Text(
                _exportFormat == ExportFormat.svg
                    ? '$_logoWidth x $_logoHeight (vector)'
                    : '${_logoWidth * _exportScale} x ${_logoHeight * _exportScale} px',
                style: TextStyle(
                  color: colors.mutedForeground,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Export button
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isExporting ? null : _handleExport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.primaryForeground,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius.md),
                  ),
                ),
                icon: _isExporting
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.primaryForeground,
                        ),
                      )
                    : const Icon(Icons.download, size: 18),
                label: Text(
                  _isExporting ? 'Exporting...' : 'Export',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: context.tweakcnColors.border),
    );
  }

  Widget _buildOptionChip(
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(radius.sm),
            border: isSelected ? null : Border.all(color: colors.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? colors.primaryForeground
                  : colors.mutedForeground,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleFontInstall() async {
    await FontInstaller.openGoogleFontsPage(_selectedFont);
  }

  Future<void> _handleExport() async {
    if (_isExporting) return;
    setState(() => _isExporting = true);

    try {
      final success = await ExportUtils.export(
        repaintKey: _repaintBoundaryKey,
        format: _exportFormat,
        targetWidth: _logoWidth,
        targetHeight: _logoHeight,
        scale: _exportFormat == ExportFormat.svg ? 1 : _exportScale,
        text: _controller.text,
        backgroundColor: _backgroundColor,
        textColor: _textColor,
        fontFamily: _selectedFont,
        fontScale: _fontScale,
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exported successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.tweakcnColors;
    final radius = context.tweakcnRadius;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(radius.sm),
              ),
              child: Icon(Icons.auto_awesome,
                  size: 18, color: colors.primaryForeground),
            ),
            const SizedBox(width: 10),
            Text(
              'Logo Generator',
              style: TextStyle(
                color: colors.foreground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: colors.foreground,
              size: 20,
            ),
            tooltip: widget.isDark ? 'Light mode' : 'Dark mode',
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: colors.border),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          if (isWide) {
            // Desktop: side-by-side
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preview (left, takes more space)
                  Expanded(
                    flex: 3,
                    child: _buildPreviewPanel(),
                  ),
                  const SizedBox(width: 16),
                  // Controls (right)
                  SizedBox(
                    width: 300,
                    child: _buildControlPanel(),
                  ),
                ],
              ),
            );
          } else {
            // Mobile: preview on top, controls below
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildPreviewPanel(),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    flex: 2,
                    child: _buildControlPanel(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
