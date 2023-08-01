import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp/chat_app/data/data_source/call/call_remote_data_source.dart';
import 'package:whatsapp/chat_app/domain/repository/base_call_repository.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

class CallingRepositoryImpl implements CallingRepository {
  final BaseCallingRemoteDataSource _remote;

  CallingRepositoryImpl(this._remote);

  Future<Result<Failure, void>> makeCall(MakeCallParams params) async {
    try {
      await _remote.makeCall(params);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<DocumentSnapshot<Object?>> callStream() {
    // TODO: implement callStream
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, void>> endCall(EndCallParams parameters) {
    // TODO: implement endCall
    throw UnimplementedError();
  }
}
