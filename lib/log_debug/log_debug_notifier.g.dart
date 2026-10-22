// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_debug_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogDebugNotifier)
final logDebugProvider = LogDebugNotifierProvider._();

final class LogDebugNotifierProvider
    extends $AsyncNotifierProvider<LogDebugNotifier, LogDebugState> {
  LogDebugNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'logDebugProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$logDebugNotifierHash();

  @$internal
  @override
  LogDebugNotifier create() => LogDebugNotifier();
}

String _$logDebugNotifierHash() => r'4d3ff3d94e466b6aa9d1e5f7691ac0d7090fbc7a';

abstract class _$LogDebugNotifier extends $AsyncNotifier<LogDebugState> {
  FutureOr<LogDebugState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LogDebugState>, LogDebugState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<LogDebugState>, LogDebugState>,
        AsyncValue<LogDebugState>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
