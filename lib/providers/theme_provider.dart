import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    _readPreferences();
    return ThemeMode.dark;
  }

  Future<void> _readPreferences() async {
    final sharedPreferences = await ref.read(preferencesProvider.future);
    final isDark =
        sharedPreferences.getBool(sharedPreferencesThemeKey) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle() async {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final sharedPreferences = await ref.read(preferencesProvider.future);
    sharedPreferences.setBool(
      sharedPreferencesThemeKey,
      state == ThemeMode.dark,
    );
  }
}
