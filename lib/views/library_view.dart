import 'dart:io';

import 'package:epubx/epubx.dart' show EpubBook;
import 'package:flipub/data/book_library.dart';
import 'package:flipub/providers/book_provider.dart';
import 'package:flipub/providers/library_provider.dart';
import 'package:flipub/views/book_cover.dart';
import 'package:flipub/views/book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibrayView extends ConsumerWidget {
  const LibrayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(bookLibraryProvider);
    return library.when(
      data: (library) {
        return _LibraryViewContent(library: library);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
    );
  }
}

class _LibraryViewContent extends StatelessWidget {
  final BookLibrary library;

  const _LibraryViewContent({
    required this.library,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Platform.isAndroid || Platform.isIOS ? 2 : 4,
          ),
          itemCount: library.bookFileNames.length,
          itemBuilder: (context, index) {
            return LibraryTile(
              bookFileName: library.bookFileNames[index],
            );
          },
        ),
      ),
    );
  }
}

class LibraryTile extends ConsumerWidget {
  const LibraryTile({super.key, required this.bookFileName});

  final String bookFileName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(bookFileName));
    return book.when(
      data: (book) {
        return _LibraryTileContent(
          bookFileName: bookFileName,
          book: book,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
    );
  }
}

class _LibraryTileContent extends StatelessWidget {
  final String bookFileName;
  final EpubBook book;

  const _LibraryTileContent({
    required this.bookFileName,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookView(
                bookFileName: bookFileName,
              ),
            ),
          );
        },
        child: Card(
          child: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BookCover(book: book),
                Text(book.Title ?? 'Unknown title'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
