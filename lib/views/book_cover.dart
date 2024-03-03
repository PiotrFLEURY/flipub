import 'dart:typed_data';

import 'package:epubx/epubx.dart' show EpubBook;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.book,
  });

  final EpubBook book;

  @override
  Widget build(BuildContext context) {
    return book.CoverImage != null
        ? Image.memory(
            Uint8List.fromList(
              image.encodePng(book.CoverImage!),
            ),
            width: 200,
            height: 200,
          )
        : const SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Text('No cover'),
            ),
          );
  }
}
