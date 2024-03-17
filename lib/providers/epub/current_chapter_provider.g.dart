// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_chapter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentChapterHash() => r'64e8109d7989e4c8c27f6527550d44bb6663459e';

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

/// See also [currentChapter].
@ProviderFor(currentChapter)
const currentChapterProvider = CurrentChapterFamily();

/// See also [currentChapter].
class CurrentChapterFamily extends Family<AsyncValue<int>> {
  /// See also [currentChapter].
  const CurrentChapterFamily();

  /// See also [currentChapter].
  CurrentChapterProvider call(
    String path,
  ) {
    return CurrentChapterProvider(
      path,
    );
  }

  @override
  CurrentChapterProvider getProviderOverride(
    covariant CurrentChapterProvider provider,
  ) {
    return call(
      provider.path,
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
  String? get name => r'currentChapterProvider';
}

/// See also [currentChapter].
class CurrentChapterProvider extends AutoDisposeFutureProvider<int> {
  /// See also [currentChapter].
  CurrentChapterProvider(
    String path,
  ) : this._internal(
          (ref) => currentChapter(
            ref as CurrentChapterRef,
            path,
          ),
          from: currentChapterProvider,
          name: r'currentChapterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentChapterHash,
          dependencies: CurrentChapterFamily._dependencies,
          allTransitiveDependencies:
              CurrentChapterFamily._allTransitiveDependencies,
          path: path,
        );

  CurrentChapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    FutureOr<int> Function(CurrentChapterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentChapterProvider._internal(
        (ref) => create(ref as CurrentChapterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _CurrentChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentChapterProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentChapterRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `path` of this provider.
  String get path;
}

class _CurrentChapterProviderElement
    extends AutoDisposeFutureProviderElement<int> with CurrentChapterRef {
  _CurrentChapterProviderElement(super.provider);

  @override
  String get path => (origin as CurrentChapterProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
