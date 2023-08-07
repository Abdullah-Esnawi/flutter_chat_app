import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/call_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/auth_viewmodel.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/core/x_state/state.dart';

final callingViewmodelProvider =
    Provider((ref) => CallingViewmodel(ref.watch(makeCallUseCaseProvider), ref, ref.watch(endCallUseCaseProvider)));

final callStreamProvider = StreamProvider((ref) => ref.watch(callStreamUseCaseProvider)(const NoParameters()));

class CallingViewmodel {
  final MakeCallUseCase _makeCallUseCase;
  final EndCallUseCase _endCallUseCase;
  final Ref _ref;

  CallingViewmodel(this._makeCallUseCase, this._ref, this._endCallUseCase);

  Future<RemoteObjectState<void>> makeCall({
    required String receiverId,
    required String receiverName,
    String? receiverPic,
    bool isGroupChat = false,
  }) async {
    RemoteObjectState<void> state = const RemoteObjectState.loading();

    final user = await _ref.watch(getUserInfoFutureProvider.future);

    final callId = const Uuid().v1();
    final receiverData = CallEntity(
      callerId: FirebaseAuth.instance.currentUser!.uid,
      callerName: user!.name,
      callerPic: user.profilePic,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverPic: receiverPic ?? '',
      callId: callId,
      hasDialled: false,
    );

    final senderData = CallEntity(
      callerId: FirebaseAuth.instance.currentUser!.uid,
      callerName: user.name,
      callerPic: user.profilePic,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverPic: receiverPic ?? '',
      callId: callId,
      hasDialled: true,
    );

    final result = await _makeCallUseCase(MakeCallParams(receiverCallData: receiverData, senderCallData: senderData));

    result.fold(
      (failure) {
        state = RemoteObjectState.error(failure.message);
      },
      (data) {
        state = RemoteObjectState.data(data);
      },
    );

    return state;
  }

  Future<void> endCall({required String callerId, required String receiverId}) async {
    final result = await _endCallUseCase(EndCallParams(callerId: callerId, receiverId: receiverId));

    result.fold((l) {
      showSnackBar(content: l.message);
    }, (r) {});
  }
}
