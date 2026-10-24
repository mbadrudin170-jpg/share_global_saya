import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  R whenDefault<R>({
    required R Function(T data) data,
    required R Function(Object e, StackTrace s) error,
    required R Function() loading,
    bool skipLoadingOnReload = true,
    bool skipLoadingOnRefresh = true,
  }) {
    return when(
      data: data,
      error: error,
      loading: loading,
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
    );
  }
}
