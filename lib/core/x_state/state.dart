
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

part 'state.freezed.dart';

// @freezed
// class ObjectRemoteState<T> with _$ObjectRemoteState<T> {
//   const ObjectRemoteState._();

//   const factory ObjectRemoteState.init() = _init<T>;
//   const factory ObjectRemoteState.loading() = _loading;
//   const factory ObjectRemoteState.success(final T data) = _success<T>;
//   const factory ObjectRemoteState.error(final ErrorModel error) = _error;

//   bool get isInit => maybeWhen(init: () => true, orElse: () => false);

//   bool get isLoading =>  maybeWhen(loading: () => true, orElse: () => false);

//   bool get isSuccess => maybeMap(success: (_) => true, orElse: () => false);

//   bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

//   T? get data => maybeWhen(success: (data) => data, orElse: () => null);
// }


@freezed
class RemoteObjectState<T> with _$RemoteObjectState<T> {
  const RemoteObjectState._();

  const factory RemoteObjectState.loading() = _RemoteObjectLoading;

  const factory RemoteObjectState.data(T data) = _RemoteObjectData<T>;

  const factory RemoteObjectState.error(String error) = _RemoteObjectError;

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get hasData => maybeWhen(data: (_) => true, orElse: () => false);

  void ifHasError(void Function(String error) function) {
    final error = maybeWhen(error: (error) => error, orElse: () => null);
    if (error != null) function(error);
  }

  R? ifHasData<R>(R Function(T data) dataFunction) {
    final data = maybeWhen(
      data: (data) => data,
      orElse: () => null,
    );
    if (data != null) {
      return dataFunction(data);
    }
    return null;
  }
}
