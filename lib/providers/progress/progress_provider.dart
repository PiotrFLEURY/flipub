import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/epub/book_provider.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'progress_provider.g.dart';

@riverpod
class Progress extends _$Progress {
  @override
  Future<double> build(String path) async {
    final SharedPreferences preferences =
        await ref.read(preferencesProvider.future);
    return preferences.getDouble('$sharedPreferencesProgressKey$path') ?? 0;
  }

  Future<void> onProgress({
    required String path,
    required int chapter,
    required double chapterProgress,
  }) async {
    final SharedPreferences preferences =
        await ref.read(preferencesProvider.future);
    final currentProgress =
        preferences.getDouble('$sharedPreferencesProgressKey$path') ?? 0;

    final book = await ref.read(bookProvider(path).future);
    final totalChapters = book.Chapters?.length ?? 0;
    final globalProgress = (chapter + chapterProgress) / totalChapters;
    if (globalProgress != currentProgress) {
      debugPrint('Saving progress $globalProgress');
      await preferences.setDouble(
        '$sharedPreferencesProgressKey$path',
        globalProgress,
      );
      await preferences.setInt(
        '$sharedPreferencesCurrentChapterKey$path',
        chapter,
      );
      await preferences.setDouble(
        '$sharedPreferencesCurrentChapterProgressKey$path',
        chapterProgress,
      );
      state = AsyncValue.data(globalProgress);
    }
  }
}
