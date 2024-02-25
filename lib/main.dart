import 'package:flipub/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flipub/app.dart';

void main() {
  final BookService bookService = BookService();
  runApp(
    Flipub(
      bookService: bookService,
    ),
  );
}
