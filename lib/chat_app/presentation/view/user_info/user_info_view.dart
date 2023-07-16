import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'dart:io';

import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';

class UserInfoView extends ConsumerStatefulWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends ConsumerState<UserInfoView> {
  TextEditingController usernameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(userInfoViewmodelProvider);
    // final userInfo = viewmodel.getCurrentUserData();
    String username = usernameController.text;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<UserInfoEntity?>(
              future: viewmodel.getCurrentUserData(),
              builder: (context, snapshot) {
                usernameController.text = snapshot.data?.name ?? '';
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        /// TODO: Use [AppAssetImage] Widget instead [NetworkImage]
                        (snapshot.data?.profilePic == null || snapshot.data!.profilePic.isEmpty)
                            ? const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://png.pngitem.com/pimgs/s/214-2145309_blank-profile-picture-circle-hd-png-download.png'),
                                radius: 64,
                              )
                            : CircleAvatar(
                                backgroundImage: (image != null
                                    ? FileImage(image!)
                                    : NetworkImage(snapshot.data!.profilePic)) as ImageProvider,
                                radius: 64,
                              ),
                        Positioned(
                          bottom: -8,
                          left: 80,
                          child: IconButton(
                            onPressed: () async {
                              image = await pickImageFromGallery(ImageSource.gallery);
                              setState(() {});
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * .85,
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(hintText: 'Enter Your Name'),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (username.isNotEmpty) {
                              viewmodel.saveUserInfoToFirebase(name: usernameController.text, profilePic: image);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                                (route) => false,
                              );
                            }
                          },
                          icon: const Icon(Icons.done),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
