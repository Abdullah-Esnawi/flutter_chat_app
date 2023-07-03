import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/chat_app/data/data_source/auth/auth_local_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/auth/auth_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/models/user_model.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/repository/auth_repository.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/save_user_data_use_case.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signin_with_phone_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/generated/l10n.dart';

class AuthRepositoryImpl extends AuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;
  final BaseAuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber(
    String phone,
  ) async {
    final result = await remoteDataSource.signInWithPhoneNumber(phone);
    try {
      return Right(result);
    } on FirebaseException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(VerifyOTPParams parameters) async {
    final result = await remoteDataSource.verifyOtp(parameters);
    try {
      return Right(result);
    } on FirebaseException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserDataToFirebase(UserDataParams parameters) async {
    final result = await remoteDataSource.saveUserDataToFirebase(parameters);
    localDataSource.setUserLoggedIn(await remoteDataSource.getCurrentUid);
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUid() async {
    final result = await remoteDataSource.getCurrentUid;
    //final result = await _getUid();
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final result = await remoteDataSource.signOut();
    await localDataSource.removeUser(localDataSource.getUser()!);
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, String>> getCachedLocalCurrentUid() async {
    final result = await localDataSource.getUser();
    try {
      return Right(result!);
    } on CachedException catch (err) {
      return Left(CachedFailure(err.message));
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> getCurrentUser() async {
    final result = await remoteDataSource.getCurrentUser();
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Future<Either<Failure, void>> setUserState(bool isOnline) async {
    final result = await remoteDataSource.setUserState(isOnline);
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }

  @override
  Stream<UserInfoModel> getUserById(String uId) {
    return remoteDataSource.getUserById(uId);
  }

  @override
  Future<Either<Failure, void>> updateProfilePic(String path) async {
    final result = await remoteDataSource.updateProfilePic(path);
    try {
      return Right(result);
    } on FirebaseAuthException catch (err) {
      return Left(ServerFailure(err.message ?? S.current.somethingWentWrong));
    }
  }
}
