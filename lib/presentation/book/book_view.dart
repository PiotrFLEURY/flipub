import 'package:epubx/epubx.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/epub/book_provider.dart';
import 'package:flipub/presentation/chapter/chapter_view.dart';
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

class _BookViewContent extends StatefulWidget {
  final EpubBook book;

  const _BookViewContent({
    required this.book,
  });

  @override
  State<_BookViewContent> createState() => _BookViewContentState();
}

class _BookViewContentState extends State<_BookViewContent> {
  EpubChapter? chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.Title ?? 'Unknown title'),
      ),
      body: Row(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: widget.book.Chapters?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () =>
                      _onChapterTap(context, widget.book.Chapters![index]),
                  child: ListTile(
                    selected: chapter == widget.book.Chapters![index],
                    title: Text(
                      widget.book.Chapters?[index].Title ?? 'Unknown chapter',
                    ),
                  ),
                );
              },
            ),
          ),
          !isMobile && chapter != null
              ? Expanded(
                  flex: 3,
                  child: ChapterView(
                    chapter: chapter!,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _onChapterTap(BuildContext context, EpubChapter chapter) {
    if (isMobile) {
      _navigateToChapterView(context, chapter);
    } else {
      setState(() {
        this.chapter = chapter;
      });
    }
  }

  void _navigateToChapterView(BuildContext context, EpubChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterView(chapter: chapter),
      ),
    );
  }
}
