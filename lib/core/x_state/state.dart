import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

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
