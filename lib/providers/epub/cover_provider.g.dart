// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookCoverHash() => r'f7432ff9a2994efe0522648c31c78b074e34df09';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [bookCover].
@ProviderFor(bookCover)
const bookCoverProvider = BookCoverFamily();

/// See also [bookCover].
class BookCoverFamily extends Family<Uint8List> {
  /// See also [bookCover].
  const BookCoverFamily();

  /// See also [bookCover].
  BookCoverProvider call(
    Image coverImage,
  ) {
    return BookCoverProvider(
      coverImage,
    );
  }

  @override
  BookCoverProvider getProviderOverride(
    covariant BookCoverProvider provider,
  ) {
    return call(
      provider.coverImage,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookCoverProvider';
}

/// See also [bookCover].
class BookCoverProvider extends AutoDisposeProvider<Uint8List> {
  /// See also [bookCover].
  BookCoverProvider(
    Image coverImage,
  ) : this._internal(
          (ref) => bookCover(
            ref as BookCoverRef,
            coverImage,
          ),
          from: bookCoverProvider,
          name: r'bookCoverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookCoverHash,
          dependencies: BookCoverFamily._dependencies,
          allTransitiveDependencies: BookCoverFamily._allTransitiveDependencies,
          coverImage: coverImage,
        );

  BookCoverProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.coverImage,
  }) : super.internal();

  final Image coverImage;

  @override
  Override overrideWith(
    Uint8List Function(BookCoverRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookCoverProvider._internal(
        (ref) => create(ref as BookCoverRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        coverImage: coverImage,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Uint8List> createElement() {
    return _BookCoverProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookCoverProvider && other.coverImage == coverImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coverImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookCoverRef on AutoDisposeProviderRef<Uint8List> {
  /// The parameter `coverImage` of this provider.
  Image get coverImage;
}

class _BookCoverProviderElement extends AutoDisposeProviderElement<Uint8List>
    with BookCoverRef {
  _BookCoverProviderElement(super.provider);

  @override
  Image get coverImage => (origin as BookCoverProvider).coverImage;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
