//~/warkop/lib/shared/widget/async_value_widget.dart
import 'package:core_shared/src/utils/l.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.skipLoadingOnReload = true,
    this.skipLoadingOnRefresh = true,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      data: data,
      loading:
          loading ?? () => const Center(child: CircularProgressIndicator()),
      error:
          error ??
          (e, s) {
            L.e('AsyncValueWidget caught an error $e $s');
            return Center(child: Text('Error: $e $s'));
          },
    );
  }
  
}

extension AsyncValueX<T> on AsyncValue<T> {
  R handle<R>({
    required R Function(T data) data,
    R Function()? loading,
    R Function(Object error, StackTrace stackTrace)? error,
    required R fallback,
    bool skipLoadingOnReload = true,
    bool skipLoadingOnRefresh = true,
  }) {
    return when(
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      data: data,
      loading: loading ?? () => fallback,
      error:
          error ??
          (e, st) {
            L.e('AsyncValue caught an error');
            return fallback;
          },
    );
  }
}
