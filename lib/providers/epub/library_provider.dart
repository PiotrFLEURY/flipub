import 'dart:async';

import 'package:flipub/data/book_library.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_provider.g.dart';

@riverpod
Future<BookLibrary> bookLibrary(BookLibraryRef ref) async {
  final preferences = await ref.watch(preferencesProvider.future);
  return BookLibrary(
    bookPathList: preferences.getStringList(sharedPreferencesLibraryKey) ?? [],
  );
}
