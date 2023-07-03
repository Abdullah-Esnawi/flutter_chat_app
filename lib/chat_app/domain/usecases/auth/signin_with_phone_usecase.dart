import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

final signInWithPhoneUseCaseProvider = Provider((ref) => SignInWithPhoneUseCase(ref.watch(authRepositoryProvider)));

class SignInWithPhoneUseCase implements BaseUseCase<void, String> {
  final AuthRepository repository;
  SignInWithPhoneUseCase(this.repository);

  @override
  Future<Result<Failure, void>> call(String phone) async {
    return await repository.signInWithPhoneNumber(phone);
  }
}
