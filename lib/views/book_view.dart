import 'package:epubx/epubx.dart';
import 'package:flipub/providers/book_provider.dart';
import 'package:flipub/views/chapter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookView extends ConsumerWidget {
  final String bookFileName;

  const BookView({
    super.key,
    required this.bookFileName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<EpubBook> book = ref.watch(bookProvider(bookFileName));
    return book.when(
      data: (EpubBook book) {
        return _BookViewContent(
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

class _BookViewContent extends StatelessWidget {
  final EpubBook book;

  const _BookViewContent({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.Title ?? 'Unknown title'),
      ),
      body: ListView.builder(
        itemCount: book.Chapters?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChapterView(chapter: book.Chapters![index]),
                ),
              );
            },
            child: ListTile(
              title: Text(book.Chapters?[index].Title ?? 'Unknown chapter'),
            ),
          );
        },
      ),
    );
  }
}
