import 'package:flutter/material.dart';
import 'package:herome/screens/home_screen.dart';
import 'package:herome/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5), brightness: Brightness.light);
    final darkScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF8B84FF), brightness: Brightness.dark);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'HeroMe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.from(colorScheme: lightScheme, useMaterial3: true).copyWith(
            appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: lightScheme.primary,
                foregroundColor: lightScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          darkTheme: ThemeData.from(colorScheme: darkScheme, useMaterial3: true),
          themeMode: mode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
  