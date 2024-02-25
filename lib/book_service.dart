import 'package:epubx/epubx.dart';
import 'package:flutter/services.dart';

class BookService {
  Future<EpubBook> parseBook(String fileName) async {
    String fullPath = 'assets/books/$fileName';
    ByteData byteData = await rootBundle.load(fullPath);
    List<int> bytes = byteData.buffer.asUint8List();
    return EpubReader.readBook(bytes);
  }
}
