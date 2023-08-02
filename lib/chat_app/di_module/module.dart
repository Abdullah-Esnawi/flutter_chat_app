import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/data_source/auth/auth_local_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/auth/auth_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/call/call_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/chat/chat_local_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/chat/chat_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/contact/contacts_local_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/contact/contacts_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/data_source/status/status_remote_data_source.dart';
import 'package:whatsapp/chat_app/data/repository/auth_repository.dart';
import 'package:whatsapp/chat_app/data/repository/call_repository.dart';
import 'package:whatsapp/chat_app/data/repository/chat_repository.dart';
import 'package:whatsapp/chat_app/data/repository/contacts_repository.dart';
import 'package:whatsapp/chat_app/data/repository/status_repository.dart';
import 'package:whatsapp/chat_app/domain/entities/message_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/set_user_state_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/auth/signout_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/call_stream_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/get_chat_contacts_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/get_chat_messages_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/contacts/get_all_contacts_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/contacts/get_selected_contact_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/get_statueses_usecase.dart';
import 'package:whatsapp/chat_app/domain/usecases/status/upload_status_usecase.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/chat_viewmodel.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/contacts_viewmodel.dart';
import 'package:whatsapp/core/usecases/base_use_cases.dart';
import 'package:whatsapp/generated/l10n.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    ref: ref,
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  ),
);

final currentUserUidProvider = StateProvider<String?>((ref) => null);

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  ),
);

final contactsLocalDataSourceProvider = Provider<ContactsLocalDataSource>((ref) => ContactsLocalDataSource());

final appCurrentLanguageProvider = StateProvider<AppLanguage>((ref) {
  final String deviceLocale = Platform.localeName.split('_')[0];
  return AppLanguage.values.firstWhere((element) => element.name == deviceLocale, orElse: () => AppLanguage.english);
});

final contactsRepositoryProvider = Provider(
  (ref) => ContactsRepository(
    ref.watch(contactsRemoteDataSourceProvider),
    ref.watch(contactsLocalDataSourceProvider),
  ),
);

final getAllContactsProvider = FutureProvider(
  (ref) {
    return ref.watch(getAllContactsUseCaseProvider).call(const NoParameters());
  },
);

final callStreamUseCaseProvider = Provider((ref) => CallStreamUseCase(ref.watch(callingRepositoryProvider)));

final contactsViewmodelProvider = Provider(
  (ref) => ContactsViewmodel(
    selectedContactsUseCase: ref.watch(selectedContactUseCaseProvider),
  ),
);
final setMessageSeenUseCaseProvider = Provider(
  (ref) => SetChatMessageSeenUseCase(ref.watch(chatRepositoryProvider)),
);

final chatViewmodelProvider = Provider((ref) => ChatViewmodel(
    ref.watch(sentTextMessageUseCase),
    ref.watch(sendFileMessageUseCaseProvider),
    ref.watch(sendGifMessageUseCaseProvider),
    ref.watch(setMessageSeenUseCaseProvider),
    ref.watch(unseenMsgsCountUsecaseProvider)));

final sendFileMessageUseCaseProvider = Provider((ref) => SendFileMessageUseCase(ref.watch(chatRepositoryProvider)));
final sendGifMessageUseCaseProvider = Provider((ref) => SendGifMessageUseCase(ref.watch(chatRepositoryProvider)));

final signOutUseCaseProvider = Provider((ref) => SignOutUseCase(ref.watch(authRepositoryProvider)));

final sentTextMessageUseCase = Provider((ref) => SendTextMessageUseCase(ref.watch(chatRepositoryProvider)));

final chatRepositoryProvider = Provider((ref) => ChatRepositoryImpl(
      ref.watch(chatRemoteDataSourceProvider),
      ref.watch(chatLocalDataSourceProvider),
    ));
final statusRemoteDataSourceProvider =
    Provider((ref) => StatusRemoteDataSource(FirebaseFirestore.instance, FirebaseAuth.instance, ref));

final statusRepositoryProvider = Provider((ref) => StatusRepositoryImpl(ref.watch(statusRemoteDataSourceProvider)));

final unseenMsgsCountUsecaseProvider = Provider((ref) => GetUnseenMessagesCount(ref.watch(chatRepositoryProvider)));

final uploadStatusUseCaseProvider = Provider((ref) => UploadStatusUseCase(ref.watch(statusRepositoryProvider)));
final getStatusUseCaseProvider = Provider((ref) => GetStatusUseCase(ref.watch(statusRepositoryProvider)));

final callingRepositoryProvider = Provider((ref) => CallingRepositoryImpl(ref.watch(callingRemoteDataSourceProvider)));
final callingRemoteDataSourceProvider = Provider((ref) => CallingRemoteDataSource(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ));

final chatRemoteDataSourceProvider = Provider((ref) => ChatRemoteDataSource(
      FirebaseFirestore.instance,
      FirebaseAuth.instance,
      ref,
    ));

final chatLocalDataSourceProvider = Provider((ref) => ChatLocalDataSource());

final chatContactsUseCaseProvider = Provider((ref) => GetChatContactsUseCase(ref.watch(chatRepositoryProvider)));
final makeCallUseCaseProvider = Provider((ref) => MakeCallUseCase(ref.watch(callingRepositoryProvider)));

final endCallUseCaseProvider = Provider((ref) => EndCallUseCase(ref.watch(callingRepositoryProvider)));

final chatMessagesUseCaseProvider = Provider((ref) => GetChatMessagesUseCase(ref.watch(chatRepositoryProvider)));

final setUserStateUseCaseProvider = Provider((ref) => SetUserStateUseCase(ref.watch(authRepositoryProvider)));

// 00971551593442

final messageReplayProvider = StateProvider<MessageReplay?>((ref) => null);

enum AppLanguage {
  english('en'),
  arabic('ar');

  final String value;

  const AppLanguage(this.value);

  String get name {
    final strings = S.current;
    switch (this) {
      case AppLanguage.english:
        return strings.changeLanguageScreenEnglish;
      case AppLanguage.arabic:
        return strings.changeLanguageScreenArabic;
    }
  }
}
