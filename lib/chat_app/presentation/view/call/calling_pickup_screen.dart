import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/data/models/call_model.dart';
import 'package:whatsapp/chat_app/presentation/view/call/components/calling_response_button.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/calling_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class CallingPickupScreen extends ConsumerStatefulWidget {
  const CallingPickupScreen(this.scaffold, {super.key});
  final Widget scaffold;
  @override
  ConsumerState<CallingPickupScreen> createState() => _CallingPickupScreenState();
}

class _CallingPickupScreenState extends ConsumerState<CallingPickupScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return ref.watch(callStreamProvider).when(
        data: (data) {
          CallModel? call = data.data() != null ? CallModel.fromMap(data.data() as Map<String, dynamic>) : null;
          if (call?.hasDialled == false) {
            return Scaffold(
              backgroundColor: const Color(0xff101D25),
              body: Stack(
                children: [
                  Positioned.fill(
                      child: AppAssetImage(
                    AppImages.chatScreenBackground,
                    color: AppColors.colors.neutral14.withOpacity(.3),
                  )),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70),
                        call!.callerPic.isEmpty
                            ? AppAssetImage(
                                AppImages.defaultProfilePicture,
                                width: 100,
                                height: 100,
                                borderRadius: BorderRadius.circular(60),
                                color: AppColors.colors.neutral14,
                                blendMode: BlendMode.color,
                              )
                            : AppCachedImage(
                                url: call.callerPic,
                                width: 100,
                                height: 100,
                                borderRadius: BorderRadius.circular(60),
                              ),
                        const SizedBox(height: 24),
                        Text(
                          call.callerName,
                          style: TextStyle(fontSize: 24, color: AppColors.colors.white, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "WhatsApp Clone Voice Call",
                          style: TextStyle(fontSize: 18, color: AppColors.colors.neutral14),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ResponseOnCallWidget(
                                onTap: () async {
                                  await ref
                                      .read(callingViewmodelProvider)
                                      .endCall(callerId: call.callId, receiverId: call.receiverId);
                                },
                                background: AppColors.colors.danger.withOpacity(.1),
                                icon: Icons.call_end,
                                iconColor: AppColors.colors.danger,
                                label: 'Decline',
                              ),
                              ResponseOnCallWidget(
                                onTap: () {},
                                background: AppColors.colors.primary,
                                icon: Icons.call,
                                iconColor: AppColors.colors.white,
                                spaceBetweenWidgets: 40,
                                label: 'Swipe up to accept',
                                isMiddleButton: true,
                              ),
                              ResponseOnCallWidget(
                                onTap: () {},
                                background: AppColors.colors.transparent,
                                icon: Icons.message,
                                iconColor: AppColors.colors.white,
                                label: 'Message',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return widget.scaffold;
        },
        error: (error, s) {
          return WidgetError(message: error.toString(), tryAgain: () {});
        },
        loading: () => const Loader());
  }
}
