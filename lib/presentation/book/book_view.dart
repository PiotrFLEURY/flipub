import 'package:epubx/epubx.dart';
import 'package:flipub/providers/epub/book_provider.dart';
import 'package:flipub/presentation/chapter/chapter_view.dart';
import 'package:flipub/providers/epub/current_chapter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookView extends ConsumerWidget {
  final String bookPath;

  const BookView({
    super.key,
    required this.bookPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<EpubBook> book = ref.watch(bookProvider(bookPath));
    return book.when(
      data: (EpubBook book) {
        return _BookViewContent(
          bookPath: bookPath,
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

class _BookViewContent extends ConsumerStatefulWidget {
  final String bookPath;
  final EpubBook book;

  const _BookViewContent({
    required this.bookPath,
    required this.book,
  });

  @override
  ConsumerState<_BookViewContent> createState() => _BookViewContentState();
}

class _BookViewContentState extends ConsumerState<_BookViewContent> {
  EpubChapter? chapter;

  @override
  void initState() {
    super.initState();
    _initCurrentChapter();
  }

  Future<void> _initCurrentChapter() async {
    final currentChapter =
        await ref.read(currentChapterProvider(widget.bookPath).future);
    if (currentChapter != 0) {
      final chapter = widget.book.Chapters![currentChapter - 1];
      setState(() {
        this.chapter = chapter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.Title ?? 'Unknown title'),
      ),
      body: chapter == null
          ? ListView.builder(
              itemCount: widget.book.Chapters?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _onChapterTap(
                    context,
                    index + 1,
                    widget.book.Chapters![index],
                  ),
                  child: ListTile(
                    selected: chapter == widget.book.Chapters![index],
                    title: Text(
                      widget.book.Chapters?[index].Title ?? 'Unknown chapter',
                    ),
                  ),
                );
              },
            )
          : ChapterView(
              bookPath: widget.bookPath,
              chapterNumber: widget.book.Chapters!.indexOf(chapter!) + 1,
              chapter: chapter!,
              onPop: _closeChapter,
            ),
    );
  }

  void _closeChapter() {
    setState(() {
      chapter = null;
    });
  }

  void _onChapterTap(
    BuildContext context,
    int chapterNumber,
    EpubChapter chapter,
  ) {
    setState(() {
      this.chapter = chapter;
    });
  }
}
