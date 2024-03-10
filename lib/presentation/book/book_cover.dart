import 'package:epubx/epubx.dart' show EpubBook;
import 'package:flipub/providers/epub/cover_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookCover extends ConsumerWidget {
  const BookCover({
    super.key,
    required this.book,
  });

  final EpubBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return book.CoverImage != null
        ? Image.memory(
            ref.read(bookCoverProvider(book.CoverImage!)),
            width: 200,
            height: 200,
          )
        : const SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Text(
                'No cover',
                style: TextStyle(
                  fontSize: 42,
                ),
              ),
            ),
          );
  }
}
