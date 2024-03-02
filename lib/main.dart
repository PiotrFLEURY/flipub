import 'package:flipub/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flipub/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  final BookService bookService = BookService();
  runApp(
    ProviderScope(
      child: Flipub(
        bookService: bookService,
      ),
    ),
  );
}
