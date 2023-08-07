import 'package:dartz/dartz.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserInfoEntity?, NoParameters> {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);
  @override
  Future<Either<Failure, UserInfoEntity?>> call(NoParameters parameters) async {
    return await _authRepository.getCurrentUser();
  }
}
