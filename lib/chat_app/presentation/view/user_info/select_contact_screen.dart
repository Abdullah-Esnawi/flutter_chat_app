import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/generated/l10n.dart';
import 'package:whatsapp/core/resources/widgets/snackbar.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllContactsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectContact),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: state.when(
        data: (result) {
          return result.fold(
              (error) => WidgetError(message: error.toString(), tryAgain: ()=> ref.watch(getAllContactsProvider),),
              (contacts) => contacts.isEmpty
                  ? Center(child: Text(S.of(context).youDontHaveContacts))
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return InkWell(
                          onTap: () async {
                            final state =
                                await ref.read(contactsViewmodelProvider).selectContact(contact.phones.first.number);

                            state.when(
                              loading: () => const Loader(),
                              data: (contact) {
                                Navigator.of(context).pushNamed(
                                  Routes.ChatScreen,
                                  arguments: {'uid': contact?.uid, 'name': contact?.name, 'profilePic': contact?.profilePic},
                                );
                              },
                              error: (error) => showSnackBar(content: error),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                contact.displayName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              leading: contact.photo == null
                                  ? null
                                  : CircleAvatar(
                                      backgroundImage: MemoryImage(contact.photo!),
                                      radius: 30,
                                    ),
                            ),
                          ),
                        );
                      },
                    ));
        },
        error: (Object error, StackTrace stackTrace) => WidgetError(message: error.toString(), tryAgain: ()  => ref.watch(getAllContactsProvider)),
        loading: () => const Loader(),
      ),
    );
  }
}
