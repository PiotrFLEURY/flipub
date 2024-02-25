import 'package:epubx/epubx.dart';
import 'package:flipub/views/chapter_view.dart';
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final EpubBook book;

  const BookView({super.key, required this.book});

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
                  builder: (context) => ChapterView(
                    chapter: book.Chapters![index],
                  ),
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
