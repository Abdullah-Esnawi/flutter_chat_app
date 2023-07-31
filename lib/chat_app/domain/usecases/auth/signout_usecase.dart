import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/error_handling/error_object.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class SignOutUseCase extends BaseUseCase<void, NoParameters> {
  final AuthRepository baseFirebaseRepository;

  SignOutUseCase(this.baseFirebaseRepository);
  @override
  Future<Result<Failure, void>> call(NoParameters parameters) async {
    return await baseFirebaseRepository.signOut();
  }
}
