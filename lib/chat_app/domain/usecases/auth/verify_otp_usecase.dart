import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/error_handling/error_object.dart';
import 'package:whatsapp/core/error_handling/failures.dart';

final verifyOTPUseCaseProvider = Provider((ref) => VerifyOTPUseCase(ref.watch(authRepositoryProvider)));

class VerifyOTPUseCase implements BaseUseCase<void, VerifyOTPParams> {
  final AuthRepository repository;
  VerifyOTPUseCase(this.repository);
  @override
  Future<Result<Failure, void>> call(VerifyOTPParams params) async {
    return await repository.verifyOtp(params);
  }
}

class VerifyOTPParams extends Equatable {
  final BuildContext context;
  final String userOTP;
  final String phone;

  const VerifyOTPParams({
    required this.context,
    required this.userOTP,
    required this.phone,
  });

  @override
  List<Object?> get props => [context, userOTP, phone];
}
