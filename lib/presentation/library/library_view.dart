import 'package:epubx/epubx.dart' show EpubBook;
import 'package:file_selector/file_selector.dart';
import 'package:flipub/data/book_library.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/providers/epub/book_provider.dart';
import 'package:flipub/providers/epub/library_provider.dart';
import 'package:flipub/providers/preferences/preferences_provider.dart';
import 'package:flipub/providers/theme/theme_provider.dart';
import 'package:flipub/presentation/book/book_cover.dart';
import 'package:flipub/presentation/book/book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibrayView extends ConsumerWidget {
  const LibrayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(bookLibraryProvider);
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).isPortrait ? 2 : 4,
          ),
          itemCount: library.bookPathList.length,
          itemBuilder: (context, index) {
            return LibraryTile(
              bookPath: library.bookPathList[index],
            );
          },
        ),
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
      final SharedPreferences preferences =
          await ref.read(preferencesProvider.future);
      final library =
          preferences.getStringList(sharedPreferencesLibraryKey) ?? [];
      if (!library.contains(path)) {
        library.add(path);
        preferences.setStringList(sharedPreferencesLibraryKey, library);
        ref.invalidate(bookLibraryProvider);
      }
    }
  }
}

class LibraryTile extends ConsumerWidget {
  const LibraryTile({super.key, required this.bookPath});

  final String bookPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(bookPath));
    return book.when(
      data: (book) {
        return _LibraryTileContent(
          bookPath: bookPath,
          book: book,
        );
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

class _LibraryTileContent extends ConsumerStatefulWidget {
  final String bookPath;
  final EpubBook book;

  const _LibraryTileContent({
    required this.bookPath,
    required this.book,
  });

  @override
  _LibraryTileContentState createState() => _LibraryTileContentState();
}

class _LibraryTileContentState extends ConsumerState<_LibraryTileContent> {
  bool _isHovering = false;

  void _onMouseEnter() {
    setState(() {
      _isHovering = true;
    });
  }

  void _onMouseExit() {
    setState(() {
      _isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onMouseEnter(),
      onExit: (_) => _onMouseExit(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookView(
                  bookPath: widget.bookPath,
                ),
              ),
            );
          },
          child: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isHovering || isMobile
                    ? InkWell(
                        onTap: () => _removeBook(ref, widget.bookPath),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[400],
                          child: const Icon(Icons.close),
                        ),
                      )
                    : const SizedBox(
                        height: 32,
                      ),
                BookCover(book: widget.book),
                Text(
                  widget.book.Title ?? 'Unknown title',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeBook(WidgetRef ref, String bookPath) async {
    final SharedPreferences preferences =
        await ref.read(preferencesProvider.future);
    final library =
        preferences.getStringList(sharedPreferencesLibraryKey) ?? [];
    library.remove(bookPath);
    preferences.setStringList(sharedPreferencesLibraryKey, library);
    ref.invalidate(bookLibraryProvider);
  }
}
