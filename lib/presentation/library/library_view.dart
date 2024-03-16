import 'package:file_selector/file_selector.dart';
import 'package:flipub/data/book_library.dart';
import 'package:flipub/presentation/library/views/book_grid_view.dart';
import 'package:flipub/presentation/library/views/empty_library.dart';
import 'package:flipub/providers/epub/library_provider.dart';
import 'package:flipub/providers/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibrayView extends ConsumerWidget {
  const LibrayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(bookLibraryNotifierProvider);
    return library.when(
      data: (library) {
        return _LibraryViewContent(library: library);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
    );
  }
}

class _LibraryViewContent extends ConsumerWidget {
  final BookLibrary library;

  const _LibraryViewContent({
    required this.library,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: [
          IconButton(
            icon: Icon(
              currentTheme == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggle();
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_open_outlined),
            onPressed: () => _pickFile(ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: library.bookPathList.isEmpty
            ? const EmptyLibraryView()
            : BookGridView(library: library),
      ),
    );
  }

  void _pickFile(WidgetRef ref) async {
    const XTypeGroup epubTypeGroup = XTypeGroup(
      label: 'epub',
      extensions: <String>['epub'],
    );
    final files = await openFiles(
      acceptedTypeGroups: <XTypeGroup>[
        epubTypeGroup,
      ],
    );
    if (files.isNotEmpty) {
      final path = files.single.path;
      ref.read(bookLibraryNotifierProvider.notifier).addBook(path);
    }
  }
}
