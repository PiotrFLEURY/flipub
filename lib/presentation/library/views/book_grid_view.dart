import 'package:flipub/data/book_library.dart';
import 'package:flipub/data/constants.dart';
import 'package:flipub/presentation/library/views/library_tile.dart';
import 'package:flutter/material.dart';

class BookGridView extends StatelessWidget {
  const BookGridView({
    super.key,
    required this.library,
  });

  final BookLibrary library;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).isPortrait ? 2 : 4,
      ),
      itemCount: library.bookPathList.length,
      itemBuilder: (context, index) {
        return LibraryTile(
          bookPath: library.bookPathList[index],
        );
      },
    );
  }
}
