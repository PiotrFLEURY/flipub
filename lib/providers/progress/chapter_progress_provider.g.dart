// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chapterProgressHash() => r'11635c422671ce4fd71a0fb8131bd585e7e73473';

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

/// See also [chapterProgress].
@ProviderFor(chapterProgress)
const chapterProgressProvider = ChapterProgressFamily();

/// See also [chapterProgress].
class ChapterProgressFamily extends Family<AsyncValue<double>> {
  /// See also [chapterProgress].
  const ChapterProgressFamily();

  /// See also [chapterProgress].
  ChapterProgressProvider call(
    String path,
  ) {
    return ChapterProgressProvider(
      path,
    );
  }

  @override
  ChapterProgressProvider getProviderOverride(
    covariant ChapterProgressProvider provider,
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
  String? get name => r'chapterProgressProvider';
}

/// See also [chapterProgress].
class ChapterProgressProvider extends AutoDisposeFutureProvider<double> {
  /// See also [chapterProgress].
  ChapterProgressProvider(
    String path,
  ) : this._internal(
          (ref) => chapterProgress(
            ref as ChapterProgressRef,
            path,
          ),
          from: chapterProgressProvider,
          name: r'chapterProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chapterProgressHash,
          dependencies: ChapterProgressFamily._dependencies,
          allTransitiveDependencies:
              ChapterProgressFamily._allTransitiveDependencies,
          path: path,
        );

  ChapterProgressProvider._internal(
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
    FutureOr<double> Function(ChapterProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChapterProgressProvider._internal(
        (ref) => create(ref as ChapterProgressRef),
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
  AutoDisposeFutureProviderElement<double> createElement() {
    return _ChapterProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterProgressProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChapterProgressRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `path` of this provider.
  String get path;
}

class _ChapterProgressProviderElement
    extends AutoDisposeFutureProviderElement<double> with ChapterProgressRef {
  _ChapterProgressProviderElement(super.provider);

  @override
  String get path => (origin as ChapterProgressProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
