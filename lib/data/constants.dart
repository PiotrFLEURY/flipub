import 'dart:io';

const sharedPreferencesFontSizeKey = 'fontSize';
const sharedPreferencesThemeKey = 'theme';

bool get isMobile => Platform.isAndroid || Platform.isIOS;
