import 'dart:io';

import 'package:flutter/widgets.dart';

const sharedPreferencesFontSizeKey = 'fontSize';
const sharedPreferencesThemeKey = 'theme';
const sharedPreferencesLibraryKey = 'library';
const sharedPreferencesProgressKey = 'progress';
const sharedPreferencesCurrentChapterProgressKey = 'currentChapterProgress';
const sharedPreferencesCurrentChapterKey = 'currentChapter';

bool get isMobile => Platform.isAndroid || Platform.isIOS;

extension OrientationExtension on MediaQueryData {
  bool get isLandscape => size.width > size.height;
  bool get isPortrait => size.width < size.height;
}
