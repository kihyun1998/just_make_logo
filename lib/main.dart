import 'package:flutter/material.dart';

import 'pages/logo_page.dart';
import 'theme/tweakcn_theme.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Generator',
      debugShowCheckedModeBanner: false,
      theme: TweakcnTheme.light,
      darkTheme: TweakcnTheme.dark,
      themeMode: _themeMode,
      home: LogoPage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
