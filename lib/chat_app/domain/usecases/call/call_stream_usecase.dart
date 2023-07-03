import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/chat_app/domain/repository/base_call_repository.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';

class CallStreamUseCase extends StreamBaseUseCase<DocumentSnapshot, NoParameters> {
  final CallRepository repository;

  CallStreamUseCase(this.repository);
  @override
  Stream<DocumentSnapshot> call(NoParameters parameters) {
    return repository.callStream();
  }
}
