import 'package:flutter/material.dart';
import 'pixel_font/pixel_font.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Art Logo Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PixelArtPage(),
    );
  }
}

class PixelArtPage extends StatefulWidget {
  const PixelArtPage({super.key});

  @override
  State<PixelArtPage> createState() => _PixelArtPageState();
}

class _PixelArtPageState extends State<PixelArtPage> {
  final TextEditingController _controller =
      TextEditingController(text: 'HELLO');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pixel Art Logo Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter text (A-Z, 0-9)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomPaint(
                    painter:
                        PixelArtPainter(_controller.text.toUpperCase()),
                    child: const SizedBox.expand(),
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
