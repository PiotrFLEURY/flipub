import 'dart:typed_data';

import 'package:image/image.dart' show Image, copyResize, encodePng;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cover_provider.g.dart';

@riverpod
Uint8List bookCover(BookCoverRef ref, Image coverImage) {
  final resizedImage = copyResize(coverImage, width: 200);
  return Uint8List.fromList(
    encodePng(resizedImage),
  );
}
