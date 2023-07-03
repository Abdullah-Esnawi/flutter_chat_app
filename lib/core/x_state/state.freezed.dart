// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RemoteObjectState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? data,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RemoteObjectLoading<T> value) loading,
    required TResult Function(_RemoteObjectData<T> value) data,
    required TResult Function(_RemoteObjectError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RemoteObjectLoading<T> value)? loading,
    TResult? Function(_RemoteObjectData<T> value)? data,
    TResult? Function(_RemoteObjectError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RemoteObjectLoading<T> value)? loading,
    TResult Function(_RemoteObjectData<T> value)? data,
    TResult Function(_RemoteObjectError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteObjectStateCopyWith<T, $Res> {
  factory $RemoteObjectStateCopyWith(RemoteObjectState<T> value,
          $Res Function(RemoteObjectState<T>) then) =
      _$RemoteObjectStateCopyWithImpl<T, $Res, RemoteObjectState<T>>;
}

/// @nodoc
class _$RemoteObjectStateCopyWithImpl<T, $Res,
        $Val extends RemoteObjectState<T>>
    implements $RemoteObjectStateCopyWith<T, $Res> {
  _$RemoteObjectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_RemoteObjectLoadingCopyWith<T, $Res> {
  factory _$$_RemoteObjectLoadingCopyWith(_$_RemoteObjectLoading<T> value,
          $Res Function(_$_RemoteObjectLoading<T>) then) =
      __$$_RemoteObjectLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_RemoteObjectLoadingCopyWithImpl<T, $Res>
    extends _$RemoteObjectStateCopyWithImpl<T, $Res, _$_RemoteObjectLoading<T>>
    implements _$$_RemoteObjectLoadingCopyWith<T, $Res> {
  __$$_RemoteObjectLoadingCopyWithImpl(_$_RemoteObjectLoading<T> _value,
      $Res Function(_$_RemoteObjectLoading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_RemoteObjectLoading<T> extends _RemoteObjectLoading<T> {
  const _$_RemoteObjectLoading() : super._();

  @override
  String toString() {
    return 'RemoteObjectState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteObjectLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? data,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RemoteObjectLoading<T> value) loading,
    required TResult Function(_RemoteObjectData<T> value) data,
    required TResult Function(_RemoteObjectError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RemoteObjectLoading<T> value)? loading,
    TResult? Function(_RemoteObjectData<T> value)? data,
    TResult? Function(_RemoteObjectError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RemoteObjectLoading<T> value)? loading,
    TResult Function(_RemoteObjectData<T> value)? data,
    TResult Function(_RemoteObjectError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _RemoteObjectLoading<T> extends RemoteObjectState<T> {
  const factory _RemoteObjectLoading() = _$_RemoteObjectLoading<T>;
  const _RemoteObjectLoading._() : super._();
}

/// @nodoc
abstract class _$$_RemoteObjectDataCopyWith<T, $Res> {
  factory _$$_RemoteObjectDataCopyWith(_$_RemoteObjectData<T> value,
          $Res Function(_$_RemoteObjectData<T>) then) =
      __$$_RemoteObjectDataCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_RemoteObjectDataCopyWithImpl<T, $Res>
    extends _$RemoteObjectStateCopyWithImpl<T, $Res, _$_RemoteObjectData<T>>
    implements _$$_RemoteObjectDataCopyWith<T, $Res> {
  __$$_RemoteObjectDataCopyWithImpl(_$_RemoteObjectData<T> _value,
      $Res Function(_$_RemoteObjectData<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_RemoteObjectData<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_RemoteObjectData<T> extends _RemoteObjectData<T> {
  const _$_RemoteObjectData(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'RemoteObjectState<$T>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteObjectData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoteObjectDataCopyWith<T, _$_RemoteObjectData<T>> get copyWith =>
      __$$_RemoteObjectDataCopyWithImpl<T, _$_RemoteObjectData<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(String error) error,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? data,
    TResult? Function(String error)? error,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RemoteObjectLoading<T> value) loading,
    required TResult Function(_RemoteObjectData<T> value) data,
    required TResult Function(_RemoteObjectError<T> value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RemoteObjectLoading<T> value)? loading,
    TResult? Function(_RemoteObjectData<T> value)? data,
    TResult? Function(_RemoteObjectError<T> value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RemoteObjectLoading<T> value)? loading,
    TResult Function(_RemoteObjectData<T> value)? data,
    TResult Function(_RemoteObjectError<T> value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _RemoteObjectData<T> extends RemoteObjectState<T> {
  const factory _RemoteObjectData(final T data) = _$_RemoteObjectData<T>;
  const _RemoteObjectData._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$_RemoteObjectDataCopyWith<T, _$_RemoteObjectData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RemoteObjectErrorCopyWith<T, $Res> {
  factory _$$_RemoteObjectErrorCopyWith(_$_RemoteObjectError<T> value,
          $Res Function(_$_RemoteObjectError<T>) then) =
      __$$_RemoteObjectErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$_RemoteObjectErrorCopyWithImpl<T, $Res>
    extends _$RemoteObjectStateCopyWithImpl<T, $Res, _$_RemoteObjectError<T>>
    implements _$$_RemoteObjectErrorCopyWith<T, $Res> {
  __$$_RemoteObjectErrorCopyWithImpl(_$_RemoteObjectError<T> _value,
      $Res Function(_$_RemoteObjectError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$_RemoteObjectError<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RemoteObjectError<T> extends _RemoteObjectError<T> {
  const _$_RemoteObjectError(this.error) : super._();

  @override
  final String error;

  @override
  String toString() {
    return 'RemoteObjectState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteObjectError<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoteObjectErrorCopyWith<T, _$_RemoteObjectError<T>> get copyWith =>
      __$$_RemoteObjectErrorCopyWithImpl<T, _$_RemoteObjectError<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) data,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? data,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? data,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RemoteObjectLoading<T> value) loading,
    required TResult Function(_RemoteObjectData<T> value) data,
    required TResult Function(_RemoteObjectError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RemoteObjectLoading<T> value)? loading,
    TResult? Function(_RemoteObjectData<T> value)? data,
    TResult? Function(_RemoteObjectError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RemoteObjectLoading<T> value)? loading,
    TResult Function(_RemoteObjectData<T> value)? data,
    TResult Function(_RemoteObjectError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _RemoteObjectError<T> extends RemoteObjectState<T> {
  const factory _RemoteObjectError(final String error) =
      _$_RemoteObjectError<T>;
  const _RemoteObjectError._() : super._();

  String get error;
  @JsonKey(ignore: true)
  _$$_RemoteObjectErrorCopyWith<T, _$_RemoteObjectError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
