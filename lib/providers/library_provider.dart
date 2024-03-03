import 'dart:async';

import 'package:flipub/data/book_library.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_provider.g.dart';

@riverpod
Future<BookLibrary> bookLibrary(BookLibraryRef ref) async {
  return const BookLibrary(
    bookFileNames: [
      'book_1.epub',
      'book_2.epub',
      'book_3.epub',
    ],
  );
}
