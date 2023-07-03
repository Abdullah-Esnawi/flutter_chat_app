import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetNumberOfMessageNotSeenUseCase extends StreamBaseUseCase<int, String> {
  final ChatRepository _repository;

  GetNumberOfMessageNotSeenUseCase(this._repository);
  @override
  Stream<int> call(String params) {
    return _repository.getNumOfMessageNotSeen(params);
  }
}
