import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/chat_app/presentation/view/camera/widgets/camera_middle_button.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

late List<CameraDescription> cameras;

final isFlashOn = StateProvider.autoDispose<bool>((ref) => false);
final cameraOrientation = StateProvider.autoDispose<int>((ref) => 0);

final cameraIsRecording = StateProvider.autoDispose((ref) => false);

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[ref.read(cameraOrientation)], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    super.dispose();
  }

  void toggleFlash() {
    ref.watch(isFlashOn)
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);

    ref.watch(isFlashOn.notifier).state = !ref.watch(isFlashOn);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.resumed) _initializeCameraController(cameraController.description);
  }

  Future<void> _initializeCameraController(CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.high,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _cameraController = cameraController;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder<void>(
          future: cameraValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned.fill(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: CameraPreview(_cameraController),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 26),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.colors.black.withOpacity(.5),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => toggleFlash(),
                              icon: Icon(
                                ref.watch(isFlashOn) ? Icons.flash_off_outlined : Icons.flash_on_outlined,
                                size: 28,
                              ),
                              color: AppColors.colors.white,
                            ),
                            CameraMiddleButton(
                              controller: _cameraController,
                              onLongPress: () {
                                if (!ref.read(cameraIsRecording)) {
                                  _cameraController.startVideoRecording();
                                  ref.read(cameraIsRecording.notifier).state = true;
                                } else {
                                  _cameraController.stopVideoRecording().then((file) {
                                    ref.read(cameraIsRecording.notifier).state = false;
                                    Navigator.pushNamed(context, Routes.pickedVideoView,
                                        arguments: {"path": file.path});
                                  });
                                }
                              },
                              onTap: () {
                                if (!ref.read(cameraIsRecording)) {
                                  _cameraController.takePicture().then((XFile? file) {
                                    if (file?.path != null) {
                                      _cameraController.dispose();

                                      Navigator.pushNamed(context, Routes.pickedImageView,
                                          arguments: {"path": file!.path});
                                    }
                                  });
                                } else {
                                  if (ref.read(cameraIsRecording)) {
                                    _cameraController.stopVideoRecording().then((file) {
                                      ref.read(cameraIsRecording.notifier).state = false;
                                      Navigator.pushNamed(context, Routes.pickedVideoView,
                                          arguments: {"path": file.path});
                                    });
                                  }
                                }
                              },
                              onLongPressUp: () {},
                            ),
                            IconButton(
                              onPressed: () {
                                ref.read(cameraOrientation.notifier).state = ref.read(cameraOrientation) == 1 ? 0 : 1;
                                cameraValue = _cameraController.initialize();
                              },
                              icon: const Icon(Icons.cameraswitch_outlined, size: 28),
                              color: AppColors.colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'Hold for video, Tap for photo',
                          style: TextStyle(color: AppColors.colors.white),
                          textAlign: TextAlign.center,
                        )
                      ]),
                    ),
                  )
                ],
              );
            } else {
              return const Loader();
            }
          }),
    );
  }
}
