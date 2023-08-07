import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/chat_app/di_module/module.dart';
import 'package:whatsapp/chat_app/domain/entities/chat_contact_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/chat/chat_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/chat_viewmodel.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return ref.watch(getChatContactsStreamProvider).when(
            data: (chatsHeader) => Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: chatsHeader.length,
                itemBuilder: (context, index) {
                  return _ContactChatItem(contact: chatsHeader[index]);
                },
              ),
            ),
            error: (error, e) =>
                WidgetError(message: error.toString(), tryAgain: () => ref.watch(getChatContactsStreamProvider)),
            loading: () => const Loader(),
          );
    });
  }
}

class _ContactChatItem extends ConsumerWidget {
  final ChatContactEntity contact;
  const _ContactChatItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  username: contact.name,
                  uid: contact.contactId,
                  profilePic: contact.profilePic,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: Text(
                contact.name.isEmpty ? contact.phoneNumber : contact.name,
                style: TextStyle(fontSize: 18, color: AppColors.colors.neutral11),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  children: [
                    // if()
                    // ...[
                    //   Icon(
                    //     Icons.done_all,
                    //     size: 20,
                    //     color: AppColors.colors.neutral55,
                    //   ),
                    //   SizedBox(width: 4),
                    // ],
                    Flexible(
                      child: Text(
                        contact.lastMessage,
                        style: TextStyle(fontSize: 15, color: AppColors.colors.neutral14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              leading: (contact.profilePic == null || contact.profilePic == '')
                  ? AppAssetImage(AppImages.defaultProfilePicture,
                      width: 60, height: 60, borderRadius: BorderRadius.circular(30))
                  : AppCachedImage(
                      url: contact.profilePic!,
                      width: 60,
                      height: 60,
                      borderRadius: BorderRadius.circular(30),
                    ),
              trailing: StreamBuilder<int>(
                  stream: ref.watch(chatViewmodelProvider).getUnseenMessagesCount(contact.contactId),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat("hh:m a").format(contact.timeSent),
                          style: TextStyle(
                            color: (snapshot.data == null || snapshot.data == 0)
                                ? AppColors.colors.neutral14
                                : const Color(0XFF25D167),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // StreamBuilder<int>(
                        //     stream: ref.watch(chatViewmodelProvider).getUnseenMessagesCount(contact.contactId),
                        //     builder: (context, snapshot) {

                        (snapshot.data == null || snapshot.data == 0)
                            ? const SizedBox.shrink()
                            : Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0XFF25D167)),
                                child: Text(
                                  snapshot.data!.toString(),
                                  style: TextStyle(fontSize: 12, color: AppColors.colors.white),
                                ),
                              ),
                        // })
                      ],
                    );
                  }),
            ),
          ),
        ),
        Divider(color: AppColors.colors.neutral17, indent: 85),
      ],
    );
  }
}
