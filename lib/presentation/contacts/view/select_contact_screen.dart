import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/presentation/common/widgets/loader.dart';
import 'package:whatsapp/presentation/contacts/viewmodel/select_contacts_viewmodel.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getContactsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: state.when(
        data: (contactList) {
          return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              final contact = contactList[index];
              return InkWell(
                onTap: () => ref.read(selectContactViewmodelProvider).selectContact(contact, context),
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
          );
        },
        error: (error, trace) => Center(
          child: Text("Error", style: Theme.of(context).textTheme.headline3),
        ), // TODO: create error screen,
        loading: () => const Loader(),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
