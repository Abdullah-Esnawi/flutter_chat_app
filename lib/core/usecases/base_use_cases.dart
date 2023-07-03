import 'package:equatable/equatable.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Result<Failure, T>> call(Parameters parameters);
}

abstract class StreamBaseUseCase<T, Parameters> {
  Stream<T> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}
