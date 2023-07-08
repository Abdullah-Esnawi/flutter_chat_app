import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<Result<Failure, UserInfoEntity?>> signInWithPhoneNumber(String phone);
  Future<Result<Failure, void>> verifyOtp(VerifyOTPParams parameters);
  Future<Result<Failure, void>> saveUserDataToFirebase(UserDataParams parameters);
  Future<Result<Failure, String>> getCurrentUid();
  Future<Result<Failure, void>> setCurrentUid(Ref ref);
  Future<Result<Failure, String>> getCachedLocalCurrentUid();
  Future<Result<Failure, void>> signOut();
  Future<Result<Failure, UserInfoEntity>> getCurrentUser();
  Stream<UserInfoEntity> getUserById(String uId);
  Future<Result<Failure, void>> setUserState(bool isOnline);
  Future<Result<Failure, void>> updateProfilePic(String path);
}
