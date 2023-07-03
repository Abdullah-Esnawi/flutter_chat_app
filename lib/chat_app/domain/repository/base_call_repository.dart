import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class CallRepository {
  Future<Either<Failure, void>> makeCall(MakeCallParams parameters);
  Future<Either<Failure, void>> endCall(EndCallParams parameters);
  Stream<DocumentSnapshot> callStream();
}
