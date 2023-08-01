import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp/core/error_handling/error_handling.dart';

abstract class CallingRepository {
  Future<Result<Failure, void>> makeCall(MakeCallParams parameters);
  Future<Result<Failure, void>> endCall(EndCallParams parameters);
  Stream<DocumentSnapshot> callStream();
}
