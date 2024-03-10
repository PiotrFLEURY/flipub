import 'dart:async';
import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_provider.g.dart';

@riverpod
Future<EpubBook> book(BookRef ref, String path) async {
  // load local file
  final EpubBook epubBook = await _loadEpubBook(path);
  return epubBook;
}

Future<EpubBook> _loadEpubBook(String path) {
  // load local file
  final File file = File(path);
  final Uint8List bytes = file.readAsBytesSync();
  return EpubReader.readBook(bytes);
}
