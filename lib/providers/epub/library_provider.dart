import 'dart:async';

import 'package:flipub/data/book_library.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'library_provider.g.dart';

@riverpod
class BookLibraryNotifier extends _$BookLibraryNotifier {
  @override
  Future<BookLibrary> build() async {
    final preferences = await ref.watch(preferencesProvider.future);
    return BookLibrary(
      bookPathList:
          preferences.getStringList(sharedPreferencesLibraryKey) ?? [],
    );
  }

  Future<void> removeBook(String bookPath) async {
    final SharedPreferences preferences =
        await ref.read(preferencesProvider.future);
    final library =
        preferences.getStringList(sharedPreferencesLibraryKey) ?? [];
    library.remove(bookPath);
    preferences.setStringList(sharedPreferencesLibraryKey, library);
    state = AsyncValue.data(BookLibrary(bookPathList: library));
  }

  Future<void> addBook(String path) async {
    final SharedPreferences preferences =
        await ref.read(preferencesProvider.future);
    final library =
        preferences.getStringList(sharedPreferencesLibraryKey) ?? [];
    if (!library.contains(path)) {
      library.add(path);
      preferences.setStringList(sharedPreferencesLibraryKey, library);
      state = AsyncValue.data(BookLibrary(bookPathList: library));
    }
  }
}
