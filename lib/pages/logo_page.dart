import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_button/flutter_dropdown_button.dart';

import '../constants/logo_constants.dart';
import '../utils/font_utils.dart';
import '../widgets/color_picker.dart';
import '../widgets/font_scale_control.dart';
import '../widgets/logo_preview.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

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

  String _selectedFont = 'Workbench';
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  String _selectedSize = '512 x 512';
  double _fontScale = 1.0;
  int _maxLines = 1;

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

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _logoWidth / _logoHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Logo Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text input
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              maxLines: _maxLines,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // Font + Size row
            Row(
              children: [
                TextOnlyDropdownButton(
                  items: LogoConstants.fonts,
                  value: _selectedFont,
                  hint: 'Font',
                  width: 160,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedFont = value);
                    }
                  },
                ),
                const SizedBox(width: 12),
                TextOnlyDropdownButton(
                  items: LogoConstants.sizePresets.map((p) => p.label).toList(),
                  value: _selectedSize,
                  hint: 'Size',
                  width: 160,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSize = value;
                        if (!_isCustomSize) {
                          final preset = LogoConstants.sizePresets.firstWhere(
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
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _widthController,
                      decoration: const InputDecoration(
                        labelText: 'W',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text('x'),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'H',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            // Font scale + Max lines row
            Row(
              children: [
                Expanded(
                  child: FontScaleControl(
                    fontScale: _fontScale,
                    onChanged: (v) => setState(() => _fontScale = v),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Lines', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 8),
                    ...List.generate(3, (i) {
                      final n = i + 1;
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: ChoiceChip(
                          label: Text('$n'),
                          selected: _maxLines == n,
                          onSelected: (_) => setState(() => _maxLines = n),
                          visualDensity: VisualDensity.compact,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Theme colors
            ColorPicker(
              label: 'Background',
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
            const SizedBox(height: 16),

            // Size indicator
            Text(
              '$_logoWidth x $_logoHeight',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Logo preview
            Expanded(
              child: LogoPreview(
                text: _controller.text,
                textStyle: getFontStyle(_selectedFont, 120, _textColor),
                backgroundColor: _backgroundColor,
                fontScale: _fontScale,
                aspectRatio: aspectRatio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
