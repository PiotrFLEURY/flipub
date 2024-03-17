// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressHash() => r'93871a645c24395678a39414ec1840da838837e0';

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

abstract class _$Progress extends BuildlessAutoDisposeAsyncNotifier<double> {
  late final String path;

  FutureOr<double> build(
    String path,
  );
}

/// See also [Progress].
@ProviderFor(Progress)
const progressProvider = ProgressFamily();

/// See also [Progress].
class ProgressFamily extends Family<AsyncValue<double>> {
  /// See also [Progress].
  const ProgressFamily();

  /// See also [Progress].
  ProgressProvider call(
    String path,
  ) {
    return ProgressProvider(
      path,
    );
  }

  @override
  ProgressProvider getProviderOverride(
    covariant ProgressProvider provider,
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
  String? get name => r'progressProvider';
}

/// See also [Progress].
class ProgressProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Progress, double> {
  /// See also [Progress].
  ProgressProvider(
    String path,
  ) : this._internal(
          () => Progress()..path = path,
          from: progressProvider,
          name: r'progressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$progressHash,
          dependencies: ProgressFamily._dependencies,
          allTransitiveDependencies: ProgressFamily._allTransitiveDependencies,
          path: path,
        );

  ProgressProvider._internal(
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
  FutureOr<double> runNotifierBuild(
    covariant Progress notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(Progress Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProgressProvider._internal(
        () => create()..path = path,
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
  AutoDisposeAsyncNotifierProviderElement<Progress, double> createElement() {
    return _ProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgressProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProgressRef on AutoDisposeAsyncNotifierProviderRef<double> {
  /// The parameter `path` of this provider.
  String get path;
}

class _ProgressProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Progress, double>
    with ProgressRef {
  _ProgressProviderElement(super.provider);

  @override
  String get path => (origin as ProgressProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
