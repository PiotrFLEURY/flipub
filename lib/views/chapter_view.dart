import 'package:epubx/epubx.dart';
import 'package:flipub/views/audio_book.dart';
import 'package:flipub/views/linear_pogress_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({
    super.key,
    required this.chapter,
  });

  final EpubChapter chapter;

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  final scrollController = ScrollController();
  final progressController = LinearProgressController();
  double progress = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final newProgress = currentScroll / maxScroll;
      progressController.onProgress(newProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.Title ?? 'Unknown title'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Html(
            data: widget.chapter.HtmlContent,
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AudioBook(
            htmlContent: widget.chapter.HtmlContent,
            onProgress: (progress) {
              debugPrint('Progress: $progress');
              scrollController.animateTo(
                progress * scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
              );
            },
          ),
          LinearProgressListener(
            controller: progressController,
          ),
        ],
      ),
    );
  }
}
