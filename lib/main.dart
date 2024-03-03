import 'package:flutter/material.dart';
import 'package:flipub/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runApp(
    const ProviderScope(
      child: Flipub(),
    ),
  );
}
