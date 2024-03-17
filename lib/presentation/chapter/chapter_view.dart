import 'dart:async';
import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:flipub/presentation/chapter/audio_book.dart';
import 'package:flipub/presentation/chapter/linear_pogress_listener.dart';
import 'package:flipub/providers/progress/chapter_progress_provider.dart';
import 'package:flipub/providers/progress/progress_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterView extends ConsumerWidget {
  const ChapterView({
    super.key,
    required this.bookPath,
    required this.chapterNumber,
    required this.chapter,
    this.onPop,
  });

  final String bookPath;
  final int chapterNumber;
  final EpubChapter chapter;
  final void Function()? onPop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    return preferences.when(
      data: (sharedPreferences) {
        return _ChapterViewInternal(
          bookPath: bookPath,
          chapterNumber: chapterNumber,
          chapter: chapter,
          sharedPreferences: sharedPreferences,
          onPop: onPop,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        debugPrint('Error: $error');
        return const Center(
          child: Text('Error loading preferences'),
        );
      },
    );
  }
}

class _ChapterViewInternal extends ConsumerStatefulWidget {
  const _ChapterViewInternal({
    required this.bookPath,
    required this.chapterNumber,
    required this.chapter,
    required this.sharedPreferences,
    this.onPop,
  });

  final String bookPath;
  final int chapterNumber;
  final EpubChapter chapter;
  final SharedPreferences sharedPreferences;
  final void Function()? onPop;

  @override
  ConsumerState<_ChapterViewInternal> createState() => _ChapterViewState();
}

class _ChapterViewState extends ConsumerState<_ChapterViewInternal>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final progressController = LinearProgressController();
  double progress = 0;
  double fontSize = 16;

  double _toolbarOpacity = 1;
  late Timer _toolbarTimer;
  late Timer _progressTimer;

  @override
  void initState() {
    super.initState();
    fontSize =
        widget.sharedPreferences.getDouble(sharedPreferencesFontSizeKey) ??
            fontSize;
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final newProgress = currentScroll / maxScroll;
      progressController.onProgress(newProgress);
      progress = newProgress;
    });
    _toolbarTimer = Timer(const Duration(seconds: 2), _hideToolbar);
    _progressTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      ref.read(progressProvider(widget.bookPath).notifier).onProgress(
            path: widget.bookPath,
            chapter: widget.chapterNumber,
            chapterProgress: progress,
          );
    });
    _initProgress();
  }

  Future<void> _initProgress() async {
    final currentProgress =
        await ref.read(chapterProgressProvider(widget.bookPath).future);
    scrollController.jumpTo(
      currentProgress * scrollController.position.maxScrollExtent,
    );
  }

  void _showToolbar() {
    setState(() {
      _toolbarOpacity = 1;
    });
  }

  void _hideToolbar() {
    setState(() {
      _toolbarOpacity = 0;
    });
  }

  @override
  void dispose() {
    _toolbarTimer.cancel();
    _progressTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        if (_toolbarOpacity == 0) {
          _showToolbar();
          _toolbarTimer.cancel();
          _toolbarTimer = Timer(const Duration(seconds: 2), _hideToolbar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarOpacity: _toolbarOpacity,
          title: Text(widget.chapter.Title ?? 'Unknown title'),
          leading: widget.onPop != null
              ? IconButton(
                  icon: const Icon(Icons.close_sharp),
                  onPressed: widget.onPop,
                )
              : null,
          actions: [
            IconButton(
              icon: const Icon(Icons.text_decrease_sharp),
              iconSize: 16,
              onPressed: _decreaseFontSize,
            ),
            Text(fontSize.toInt().toString()),
            IconButton(
              icon: const Icon(Icons.text_increase_sharp),
              onPressed: _increaseFontSize,
            ),
            const SizedBox(width: 24),
          ],
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Html(
              style: {
                'body': Style(
                  fontSize: FontSize(fontSize),
                  fontFamily: 'Times New Roman',
                ),
              },
              data: widget.chapter.HtmlContent,
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kIsWeb || Platform.isAndroid || Platform.isIOS)
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
      ),
    );
  }

  void _decreaseFontSize() {
    setState(() {
      fontSize = fontSize - 1;
      widget.sharedPreferences.setDouble(
        sharedPreferencesFontSizeKey,
        fontSize,
      );
    });
  }

  void _increaseFontSize() {
    setState(() {
      fontSize = fontSize + 1;
      widget.sharedPreferences.setDouble(
        sharedPreferencesFontSizeKey,
        fontSize,
      );
    });
  }
}
