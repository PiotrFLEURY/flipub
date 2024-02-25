import 'package:epubx/epubx.dart';
import 'package:flipub/book_service.dart';
import 'package:flipub/views/book_view.dart';
import 'package:flutter/material.dart';

class Flipub extends StatelessWidget {
  const Flipub({super.key, required this.bookService});

  final BookService bookService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder<EpubBook>(
        future: bookService.parseBook(
          'book_1.epub',
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BookView(book: snapshot.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
