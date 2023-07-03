import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/repository/base_call_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class EndCallUseCase extends BaseUseCase<void, EndCallParams> {
  final CallRepository _repository;

  EndCallUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(EndCallParams params) async {
    return await _repository.endCall(params);
  }
}

class EndCallParams extends Equatable {
  final String callerId;
  final String receiverId;

  const EndCallParams({
    required this.callerId,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [
        callerId,
        receiverId,
      ];
}
