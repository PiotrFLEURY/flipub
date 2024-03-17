import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_chapter_provider.g.dart';

@riverpod
Future<int> currentChapter(CurrentChapterRef ref, String path) async {
  final preferences = await ref.watch(preferencesProvider.future);
  return preferences.getInt('$sharedPreferencesCurrentChapterKey$path') ?? 0;
}
