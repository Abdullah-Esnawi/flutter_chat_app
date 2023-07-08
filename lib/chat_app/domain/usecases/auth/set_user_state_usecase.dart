import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/error_handling/error_object.dart';
import 'package:whatsapp/core/error_handling/failures.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SetUserStateUseCase extends BaseUseCase<void, bool> {
  SetUserStateUseCase(this._repository);
  final AuthRepository _repository;
  @override
  Future<Result<Failure, void>> call(bool isOnline) async {
    return await _repository.setUserState(isOnline);
  }
}
