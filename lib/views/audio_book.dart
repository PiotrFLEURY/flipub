import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:html/parser.dart';

class AudioBook extends StatefulWidget {
  const AudioBook({
    super.key,
    required this.htmlContent,
    required this.onProgress,
  });

  final String? htmlContent;
  final Function(double) onProgress;

  @override
  State<AudioBook> createState() => _AudioBookState();
}

class _AudioBookState extends State<AudioBook> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  bool isPaused = false;
  Queue<String> toRead = Queue();
  int initialSize = 0;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      //
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        isPlaying = false;
      });
    });

    flutterTts.setLanguage("fr-FR");
    flutterTts.awaitSpeakCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: parseHtml(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final text = snapshot.data as String;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _stopAudio();
                },
                icon: const Icon(Icons.stop),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  _playAudio(context, text);
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  _skipNext();
                },
                icon: const Icon(Icons.skip_next),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<String> parseHtml() async {
    var document = parse(widget.htmlContent ?? '<div></div>');
    var bodyHtml = document.body?.innerHtml ?? 'No content';
    var bodyHtmlWithLineBreaks = bodyHtml.replaceAll('</p>', '\n');
    var bodyTextWithLineBreaks =
        parse(bodyHtmlWithLineBreaks).documentElement?.text ?? 'No content';
    //debugPrint('Parsed text: $bodyTextWithLineBreaks');
    return bodyTextWithLineBreaks;
  }

  void _playAudio(BuildContext context, String text) {
    if (isPlaying) {
      if (isPaused) {
        _resumeAudio();
      } else {
        _pauseAudio();
      }
      _pauseAudio();
    } else {
      toRead.clear();
      toRead.addAll(text.split('\n'));
      initialSize = text.length;
      _next();
    }
  }

  void _pauseAudio() {
    flutterTts.stop();
    setState(() {
      isPlaying = true;
      isPaused = true;
    });
  }

  void _stopAudio() {
    toRead.clear();
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
    widget.onProgress(0);
    flutterTts.stop();
  }

  void _resumeAudio() {
    _next();
  }

  Future<void> _next() async {
    while (toRead.isNotEmpty) {
      final progressPercentage =
          (initialSize - toRead.join("\n").length) / initialSize;
      widget.onProgress(progressPercentage);
      final readingLine = toRead.removeFirst();
      if (readingLine.isNotEmpty) {
        await flutterTts.speak(readingLine);
      }
    }
    _stopAudio();
  }

  void _skipNext() {
    flutterTts.stop();
  }
}
