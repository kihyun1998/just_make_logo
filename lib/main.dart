import 'package:flutter/material.dart';

import 'pages/logo_page.dart';
import 'theme/tweakcn_theme.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Generator',
      debugShowCheckedModeBanner: false,
      theme: TweakcnTheme.light,
      darkTheme: TweakcnTheme.dark,
      themeMode: ThemeMode.dark,
      home: const LogoPage(),
    );
  }
}
