import 'package:flipub/providers/theme/theme_provider.dart';
import 'package:flipub/presentation/library/library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Flipub extends StatelessWidget {
  const Flipub({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: _FlipubContent());
  }
}

class _FlipubContent extends ConsumerWidget {
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
