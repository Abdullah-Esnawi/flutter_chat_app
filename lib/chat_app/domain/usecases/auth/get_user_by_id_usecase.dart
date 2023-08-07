import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetUserByIdUseCase extends StreamBaseUseCase<UserInfoEntity, String> {
  final AuthRepository _baseAuthRepository;

  GetUserByIdUseCase(this._baseAuthRepository);

  @override
  Stream<UserInfoEntity> call(String parameters) {
    return _baseAuthRepository.getUserById(parameters);
  }
}
