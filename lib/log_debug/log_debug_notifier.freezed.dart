// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_debug_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogDebugState implements DiagnosticableTreeMixin {

 List<LogDebugModel> get listLogDebug;
/// Create a copy of LogDebugState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogDebugStateCopyWith<LogDebugState> get copyWith => _$LogDebugStateCopyWithImpl<LogDebugState>(this as LogDebugState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as LogDebugState;
  properties
    ..add(DiagnosticsProperty('type', 'LogDebugState'))
    ..add(DiagnosticsProperty('listLogDebug', _this.listLogDebug));
}

@override
bool operator ==(Object other) {
  final _this = this as LogDebugState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogDebugState&&const DeepCollectionEquality().equals(other.listLogDebug, _this.listLogDebug));
}


@override
int get hashCode {
  final _this = this as LogDebugState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listLogDebug));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as LogDebugState;
  return 'LogDebugState(listLogDebug: ${_this.listLogDebug})';
}


}

/// @nodoc
abstract mixin class $LogDebugStateCopyWith<$Res>  {
  factory $LogDebugStateCopyWith(LogDebugState value, $Res Function(LogDebugState) _then) = _$LogDebugStateCopyWithImpl;
@useResult
$Res call({
 List<LogDebugModel> listLogDebug
});




}
/// @nodoc
class _$LogDebugStateCopyWithImpl<$Res>
    implements $LogDebugStateCopyWith<$Res> {
  _$LogDebugStateCopyWithImpl(this._self, this._then);

  final LogDebugState _self;
  final $Res Function(LogDebugState) _then;

/// Create a copy of LogDebugState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listLogDebug = null,}) {
  return _then(LogDebugState(
listLogDebug: null == listLogDebug ? _self.listLogDebug : listLogDebug // ignore: cast_nullable_to_non_nullable
as List<LogDebugModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [LogDebugState].
extension LogDebugStatePatterns on LogDebugState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogDebugState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogDebugState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogDebugState value)  $default,){
final _that = this;
switch (_that) {
case _LogDebugState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogDebugState value)?  $default,){
final _that = this;
switch (_that) {
case _LogDebugState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LogDebugModel> listLogDebug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogDebugState() when $default != null:
return $default(_that.listLogDebug);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LogDebugModel> listLogDebug)  $default,) {final _that = this;
switch (_that) {
case _LogDebugState():
return $default(_that.listLogDebug);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LogDebugModel> listLogDebug)?  $default,) {final _that = this;
switch (_that) {
case _LogDebugState() when $default != null:
return $default(_that.listLogDebug);case _:
  return null;

}
}

}

/// @nodoc


class _LogDebugState extends LogDebugState with DiagnosticableTreeMixin {
  const _LogDebugState({ List<LogDebugModel> listLogDebug = const []}): _listLogDebug = listLogDebug,super._();
  

 final  List<LogDebugModel> _listLogDebug;
@override@JsonKey() List<LogDebugModel> get listLogDebug {
  if (_listLogDebug is EqualUnmodifiableListView) return _listLogDebug;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listLogDebug);
}


/// Create a copy of LogDebugState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogDebugStateCopyWith<_LogDebugState> get copyWith => __$LogDebugStateCopyWithImpl<_LogDebugState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'LogDebugState'))
    ..add(DiagnosticsProperty('listLogDebug', listLogDebug));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogDebugState&&const DeepCollectionEquality().equals(other.listLogDebug, _listLogDebug));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listLogDebug));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'LogDebugState(listLogDebug: $listLogDebug)';
}


}

/// @nodoc
abstract mixin class _$LogDebugStateCopyWith<$Res> implements $LogDebugStateCopyWith<$Res> {
  factory _$LogDebugStateCopyWith(_LogDebugState value, $Res Function(_LogDebugState) _then) = __$LogDebugStateCopyWithImpl;
@override @useResult
$Res call({
 List<LogDebugModel> listLogDebug
});




}
/// @nodoc
class __$LogDebugStateCopyWithImpl<$Res>
    implements _$LogDebugStateCopyWith<$Res> {
  __$LogDebugStateCopyWithImpl(this._self, this._then);

  final _LogDebugState _self;
  final $Res Function(_LogDebugState) _then;

/// Create a copy of LogDebugState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listLogDebug = null,}) {
  return _then(_LogDebugState(
listLogDebug: null == listLogDebug ? _self._listLogDebug : listLogDebug // ignore: cast_nullable_to_non_nullable
as List<LogDebugModel>,
  ));
}


}

// dart format on
