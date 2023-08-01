import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/chat_app/data/models/call_model.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';

class CallingRemoteDataSource implements BaseCallingRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  CallingRemoteDataSource(this._auth, this._firestore);

  @override
  Future<void> makeCall(MakeCallParams params) async {

   var senEntityData =  params.senderCallData;
    final senderData = CallModel(
      callerId: senEntityData.callerId,
      callerName: senEntityData.callerName,
      callerPic: senEntityData.callerPic,
      receiverId: senEntityData.receiverId,
      receiverName: senEntityData.receiverName,
      receiverPic: senEntityData.receiverPic,
      callId: senEntityData.callId,
      hasDialled: senEntityData.hasDialled,
    );
    await _firestore.collection('call').doc(params.senderCallData.callerId).set(senderData.toMap());

   var recEntityData =  params.receiverCallData;
    final receiverData = CallModel(
      callerId: recEntityData.callerId,
      callerName: recEntityData.callerName,
      callerPic: recEntityData.callerPic,
      receiverId: recEntityData.receiverId,
      receiverName: recEntityData.receiverName,
      receiverPic: recEntityData.receiverPic,
      callId: recEntityData.callId,
      hasDialled: recEntityData.hasDialled,
    );
    await _firestore.collection('call').doc(params.senderCallData.receiverId).set(receiverData.toMap());
  }

  @override
  Stream<DocumentSnapshot> callStream() => _firestore.collection('call').doc(_auth.currentUser!.uid).snapshots();

  @override
  Future<void> endCall(EndCallParams parameters) async {
    await _firestore.collection('call').doc(parameters.callerId).delete();
    await _firestore.collection('call').doc(parameters.receiverId).delete();
  }
}

abstract class BaseCallingRemoteDataSource {
  Future<void> makeCall(MakeCallParams params);
  Future<void> endCall(EndCallParams parameters);
  Stream<DocumentSnapshot> callStream();
}
