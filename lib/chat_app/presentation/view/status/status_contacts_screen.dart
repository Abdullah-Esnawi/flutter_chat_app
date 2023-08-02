import 'package:collection/collection.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/status/components/status_widget.dart';
import 'package:whatsapp/chat_app/presentation/view/status/components/stories_title.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/status_viewmodel.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class StatusScreen extends ConsumerWidget {
  StatusScreen({super.key});
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<String?> userProfilePic(WidgetRef ref) async {
    var user = await ref.watch(userInfoProvider.future);

    return user?.profilePic;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userInfoProvider.future);
    return FutureBuilder<List<StatusEntity>>(
        future: ref.watch(statusViewmodelProvider).getStatuses(),
        builder: (context, snapshot) {
          final currentUserStatusData = snapshot.data?.firstWhereOrNull((element) => element.uid == userId);
          return Column(children: [
            if (currentUserStatusData != null)
              StatusItemWidget(
                status: currentUserStatusData,
                onTap: () {
                  Navigator.pushNamed(context, Routes.statusViewScreen, arguments: {'status': currentUserStatusData});
                },
                onOwnStatusTap: () {},
                showEmptyViewStatus: false,
              )
            else
              StatusItemWidget(
                status: StatusEntity(
                  uid: '',
                  username: "My status",
                  phoneNumber: '',
                  photoUrl: [],
                  createdAt: DateTime.now(),
                  profilePic: '',
                  statusId: '',
                  whoCanSee: [],
                ),
                onTap: () async {
                  var file = await pickImageFromGallery(ImageSource.gallery);
                  if (file != null) {
                    Navigator.pushNamed(context, Routes.pickedImageView, arguments: {'path': file.path});
                  }
                },
                onOwnStatusTap: () {},
                showEmptyViewStatus: true,
              ),
            const StoriesTitle('Recent updates'),
            Expanded(
              child: snapshot.data != null
                  ? ListView.builder(
                      cacheExtent: 99999,
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return StatusItemWidget(
                            status: item,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.statusViewScreen, arguments: {'status': item});
                            });
                      },
                    )
                  : const Loader(),
            )
          ]);
        });
  }
}
