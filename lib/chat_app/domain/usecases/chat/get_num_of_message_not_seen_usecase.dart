import 'package:whatsapp/chat_app/domain/repository/chat_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetUnseenMessagesCount extends StreamBaseUseCase<int, String> {
  final ChatRepository _repository;

  GetUnseenMessagesCount(this._repository);
  @override
  Stream<int> call(String senderId) {
    return _repository.getNumOfMessageNotSeen(senderId);
  }
}
