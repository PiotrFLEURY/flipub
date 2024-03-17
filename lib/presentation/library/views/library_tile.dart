import 'package:epubx/epubx.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/presentation/book/book_cover.dart';
import 'package:flipub/presentation/book/book_view.dart';
import 'package:flipub/presentation/library/views/book_progress_view.dart';
import 'package:flipub/providers/epub/book_provider.dart';
import 'package:flipub/providers/epub/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        return InkWell(
          onTap: () {
            ref.read(bookLibraryNotifierProvider.notifier).removeBook(bookPath);
          },
          child: Center(
            child: Text('Error: $error'),
          ),
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
                        onTap: () => ref
                            .read(bookLibraryNotifierProvider.notifier)
                            .removeBook(widget.bookPath),
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
                BookProgressView(
                  path: widget.bookPath,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
