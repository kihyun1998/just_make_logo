import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dropdown_button/flutter_dropdown_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LogoPage(),
    );
  }
}

class _SizePreset {
  final String label;
  final int width;
  final int height;
  const _SizePreset(this.label, this.width, this.height);
}

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  final TextEditingController _controller =
      TextEditingController(text: 'HELLO');
  final TextEditingController _widthController =
      TextEditingController(text: '512');
  final TextEditingController _heightController =
      TextEditingController(text: '512');

  String _selectedFont = 'Workbench';
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  String _selectedSize = '512 x 512';

  static const List<String> _fonts = ['Workbench', 'Jersey 20', 'Noto Serif'];

  static const List<Color> _colors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  static const List<_SizePreset> _sizePresets = [
    _SizePreset('512 x 512', 512, 512),
    _SizePreset('1024 x 1024', 1024, 1024),
    _SizePreset('192 x 192', 192, 192),
    _SizePreset('Custom', 0, 0),
  ];

  bool get _isCustomSize => _selectedSize == 'Custom';

  int get _logoWidth {
    if (_isCustomSize) return int.tryParse(_widthController.text) ?? 512;
    return _sizePresets.firstWhere((p) => p.label == _selectedSize).width;
  }

  int get _logoHeight {
    if (_isCustomSize) return int.tryParse(_heightController.text) ?? 512;
    return _sizePresets.firstWhere((p) => p.label == _selectedSize).height;
  }

  TextStyle _getFontStyle(double fontSize) {
    switch (_selectedFont) {
      case 'Jersey 20':
        return GoogleFonts.jersey20(fontSize: fontSize, color: _textColor);
      case 'Noto Serif':
        return GoogleFonts.notoSerif(fontSize: fontSize, color: _textColor);
      case 'Workbench':
      default:
        return GoogleFonts.workbench(fontSize: fontSize, color: _textColor);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Widget _buildColorPicker(
      String label, Color selected, ValueChanged<Color> onSelect) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        ..._colors.map((color) {
          final isSelected = selected == color;
          return GestureDetector(
            onTap: () => onSelect(color),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey,
                  width: isSelected ? 2.5 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ],
    );
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
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // Font + Size row
            Row(
              children: [
                TextOnlyDropdownButton(
                  items: _fonts,
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
                  items: _sizePresets.map((p) => p.label).toList(),
                  value: _selectedSize,
                  hint: 'Size',
                  width: 160,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSize = value;
                        if (!_isCustomSize) {
                          final preset = _sizePresets
                              .firstWhere((p) => p.label == value);
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

            // Theme colors
            _buildColorPicker('Background', _backgroundColor,
                (c) => setState(() => _backgroundColor = c)),
            const SizedBox(height: 8),
            _buildColorPicker(
                'Text', _textColor, (c) => setState(() => _textColor = c)),
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
              child: Center(
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              _controller.text,
                              style: _getFontStyle(120),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
