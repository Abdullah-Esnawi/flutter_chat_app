import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

final saveUserDataUseCaseProvider = Provider((ref) {
  return SaveUserDataToFirebaseUseCase(ref.watch(authRepositoryProvider));
});

class SaveUserDataToFirebaseUseCase extends BaseUseCase<void, UserDataParams> {
  final AuthRepository repository;

  SaveUserDataToFirebaseUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(UserDataParams params) async {
    return await repository.saveUserDataToFirebase(params);
  }
}

class UserDataParams extends Equatable {
  final String name;
  final File? profilePic;

  const UserDataParams({required this.name, this.profilePic});

  @override
  List<Object?> get props => [
        name,
        profilePic,
      ];
}
