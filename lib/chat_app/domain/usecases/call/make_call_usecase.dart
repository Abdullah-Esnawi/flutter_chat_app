import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp/chat_app/domain/entities/call_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/base_call_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class MakeCallUseCase extends BaseUseCase<void, MakeCallParams> {
  final CallingRepository _baseCallRepository;

  MakeCallUseCase(this._baseCallRepository);

  @override
  Future<Either<Failure, void>> call(MakeCallParams params) async {
    return await _baseCallRepository.makeCall(params);
  }
}

class MakeCallParams extends Equatable {
  final CallEntity receiverCallData;
  final CallEntity senderCallData;

  const MakeCallParams({
    required this.receiverCallData,
    required this.senderCallData,
  });

  @override
  List<Object?> get props => [
        receiverCallData,
        senderCallData,
      ];
}
