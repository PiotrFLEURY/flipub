import 'dart:async';

import 'package:epubx/epubx.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_provider.g.dart';

@riverpod
Future<EpubBook> book(BookRef ref, String fileName) async {
  String fullPath = 'assets/books/$fileName';
  ByteData byteData = await rootBundle.load(fullPath);
  List<int> bytes = byteData.buffer.asUint8List();
  return EpubReader.readBook(bytes);
}
