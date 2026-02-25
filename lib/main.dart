import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/logo_page.dart';
import 'providers/theme_provider.dart';
import 'theme/tweakcn_theme.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Logo Generator',
      debugShowCheckedModeBanner: false,
      theme: TweakcnTheme.light,
      darkTheme: TweakcnTheme.dark,
      themeMode: themeMode,
      home: const LogoPage(),
    );
  }
}
