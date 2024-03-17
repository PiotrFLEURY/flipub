import 'package:flipub/providers/progress/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookProgressView extends ConsumerWidget {
  const BookProgressView({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider(path));
    return progress.when(
      data: _bookProgressViewContent,
      error: _progressError,
      loading: _progressLoading,
    );
  }

  Widget _bookProgressViewContent(double progress) {
    final progressPercentage = (progress * 100).toInt();
    return Chip(
      label: Text(
        '$progressPercentage %',
      ),
    );
  }

  Widget _progressError(Object error, StackTrace stackTrace) {
    return Center(
      child: Text('Error: $error'),
    );
  }

  Widget _progressLoading() {
    return const Text('...');
  }
}
