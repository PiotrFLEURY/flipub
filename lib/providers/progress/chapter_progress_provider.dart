import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_progress_provider.g.dart';

@riverpod
Future<double> chapterProgress(
  ChapterProgressRef ref,
  String path,
) async {
  final preferences = await ref.watch(preferencesProvider.future);
  final currentChapterProgress = preferences.getDouble(
        '$sharedPreferencesCurrentChapterProgressKey$path',
      ) ??
      0;
  return currentChapterProgress;
}
