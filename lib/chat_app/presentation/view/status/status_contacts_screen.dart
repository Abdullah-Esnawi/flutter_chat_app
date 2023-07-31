import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/presentation/view/status/components/stories_title.dart';
import 'package:whatsapp/chat_app/presentation/view/status/components/status_widget.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/status_viewmodel.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class StatusScreen extends ConsumerWidget {
  StatusScreen({super.key});
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<StatusEntity>>(
        future: ref.watch(statusViewmodelProvider).getStatuses(),
        builder: (context, snapshot) {
          ;
          // final currentUserStatusData = snapshot.data?.map((element) => element.uid == userId ? element : null).first;
          return Column(children: [
            // if (currentUserStatusData != null)
            //   StatusItemWidget(
            //     status: currentUserStatusData,
            //     onTap: () {},
            //     onOwnStatusTap: () {},
            //   ),
            StatusItemWidget(
              status: StatusEntity(
                  uid: 'uid',
                  username: "My status",
                  phoneNumber: "phoneNumber",
                  photoUrl: ['photoUrl', '', '', '', ''],
                  createdAt: DateTime.now().subtract(Duration(hours: 4)),
                  profilePic: 'https://git.code95.info/uploads/-/system/user/avatar/158/avatar.png',
                  statusId: 'statusId',
                  whoCanSee: ['whoCanSee', '']),
              onTap: () {},
            ),
            const StoriesTitle('Recent updates'),
            Expanded(
              // child: snapshot.data != null
              //     ? ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: snapshot.data!.length,
              //         itemBuilder: (context, index) {
              //           print(index);
              //           var item = snapshot.data![index];
              //           print(item);
              //           return Text('data');
              //         },
              //       )
              //     : const Loader(),
              child: ListView(shrinkWrap: true, children: [
                StatusItemWidget(
                  status: StatusEntity(
                      uid: 'uid',
                      username: "Ali Mohamed",
                      phoneNumber: "phoneNumber",
                      photoUrl: ['photoUrl', '', '', ''],
                      createdAt: DateTime.now().subtract(Duration(hours: 4)),
                      profilePic:
                          'https://images.pexels.com/photos/4348556/pexels-photo-4348556.jpeg?auto=compress&cs=tinysrgb',
                      statusId: 'statusId',
                      whoCanSee: ['whoCanSee', '']),
                  onTap: () {},
                ),
                StatusItemWidget(
                  status: StatusEntity(
                      uid: 'uid',
                      username: "Abdullah Mohamed",
                      phoneNumber: "phoneNumber",
                      photoUrl: ['photoUrl', '', '', ''],
                      createdAt: DateTime.now().subtract(Duration(hours: 4)),
                      profilePic:
                          'https://images.pexels.com/photos/1939485/pexels-photo-1939485.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      statusId: 'statusId',
                      whoCanSee: ['whoCanSee', '']),
                  onTap: () {},
                ),
                StatusItemWidget(
                  status: StatusEntity(
                      uid: 'uid',
                      username: "Mohamed Ahmed",
                      phoneNumber: "phoneNumber",
                      photoUrl: ['photoUrl', '', '', '', ''],
                      createdAt: DateTime.now().subtract(Duration(hours: 4)),
                      profilePic:
                          'https://images.pexels.com/photos/2397645/pexels-photo-2397645.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      statusId: 'statusId',
                      whoCanSee: ['whoCanSee', '']),
                  onTap: () {},
                ),
                StatusItemWidget(
                  status: StatusEntity(
                      uid: 'uid',
                      username: "Ali Mohamed",
                      phoneNumber: "phoneNumber",
                      photoUrl: ['photoUrl', ''],
                      createdAt: DateTime.now().subtract(Duration(hours: 4)),
                      profilePic:
                          'https://images.pexels.com/photos/235986/pexels-photo-235986.jpeg?auto=compress&cs=tinysrgb&',
                      statusId: 'statusId',
                      whoCanSee: ['whoCanSee', '']),
                  onTap: () {},
                )
              ]),
            )
          ]);
        });
  }
}
