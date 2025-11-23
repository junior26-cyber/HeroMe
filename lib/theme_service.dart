import 'package:flutter/material.dart';

/// Notifier global pour piloter le ThemeMode de l'app
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);