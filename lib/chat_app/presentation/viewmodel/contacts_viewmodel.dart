import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/domain/usecases/contacts/get_selected_contact_usecase.dart';
import 'package:whatsapp/core/x_state/state.dart';

class ContactsViewmodel {
  final GetSelectedContactUseCase selectedContactsUseCase;

  ContactsViewmodel({required this.selectedContactsUseCase});

  Future<RemoteObjectState<UserInfoEntity?>> selectContact(String phone) async {
    RemoteObjectState<UserInfoEntity?> state = const RemoteObjectState.loading();
    final result = await selectedContactsUseCase(phone);
    result.fold(
      (failure) {
        state = RemoteObjectState.error(failure.message);
      },
      (contact) {
        state = RemoteObjectState.data(contact);
      },
    );

    return state;
  }
}
