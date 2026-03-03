import 'dart:io';

class FontInstaller {
  /// Opens the Google Fonts page for the given font family
  /// so the user can download and install it manually.
  static Future<void> openGoogleFontsPage(String fontFamily) async {
    final query = fontFamily.replaceAll(' ', '+');
    final url = 'https://fonts.google.com/specimen/$query';
    if (Platform.isMacOS) {
      await Process.run('open', [url]);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', [url]);
    } else if (Platform.isWindows) {
      await Process.run('cmd', ['/c', 'start', '', url]);
    }
  }
}
