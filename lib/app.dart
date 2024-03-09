import 'package:flipub/providers/theme_provider.dart';
import 'package:flipub/views/library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Flipub extends ConsumerWidget {
  const Flipub({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeMode == ThemeMode.dark ? ThemeData.dark() : ThemeData.light(),
      home: const LibrayView(),
    );
  }
}
