import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'dart:io';

import 'package:whatsapp/core/resources/widgets/file_picker.dart';
import 'package:whatsapp/chat_app/presentation/view/main_navigations/main_navigation_screen.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/generated/l10n.dart';

class UserInfoView extends ConsumerStatefulWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends ConsumerState<UserInfoView> {
  TextEditingController usernameController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
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
                usernameController.text = snapshot.data?.name ?? usernameController.text;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.file(
                                  image!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : (snapshot.data?.profilePic == null || snapshot.data!.profilePic.isEmpty)
                                ? AppAssetImage(
                                    AppImages.defaultProfilePicture,
                                    width: 120,
                                    height: 120,
                                    borderRadius: BorderRadius.circular(60),
                                  )
                                : AppCachedImage(
                                    url: snapshot.data!.profilePic,
                                    width: 120,
                                    height: 120,
                                    borderRadius: BorderRadius.circular(60),
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
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * .85,
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).enterName;
                                }
                                return null;
                              },
                              controller: usernameController,
                              decoration: InputDecoration(hintText: S.of(context).enterName),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await viewmodel.saveUserInfoToFirebase(
                                  name: usernameController.text,
                                  profilePic: image,
                                  context: context,
                                );
                              }
                            },
                            icon: const Icon(Icons.done),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
