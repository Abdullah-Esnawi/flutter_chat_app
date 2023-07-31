import 'package:dartz/dartz.dart';
import 'package:whatsapp/chat_app/data/data_source/status/status_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/models/status_model.dart';
import 'package:whatsapp/chat_app/domain/repository/status_repository.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/upload_status_usecase.dart';
import 'package:whatsapp/core/error_handling/error_object.dart';
import 'package:whatsapp/core/error_handling/failures.dart';

class StatusRepositoryImpl implements StatusRepository {
  final BaseStatusRemoteDataSource _remote;

  StatusRepositoryImpl(this._remote);

  @override
  Future<Result<Failure, void>> uploadStatus(UploadStatusParams params) async {
    try {
      final result = await _remote.uploadStatus(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<StatusModel>>> getStatuses() async {
    try {
      return Right(await _remote.getStatuses());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
