import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/widgets/custom_button.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/auth_viewmodel.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/core/resources/widgets/loader.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void dispose() {
    // ref.watch(authViewmodelProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = ref.watch(countryPickerProvider.notifier).state;
    final viewmodel = ref.watch(authViewmodelProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Enter Your Phone number",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: set right color and remove hard code
            const Text("Whatsapp will need to verify your phone number"),
            const SizedBox(height: 10),
            TextButton(onPressed: () => viewmodel.pickCountry(context), child: const Text("Pick Country")),
            const SizedBox(height: 5),
            Row(
              children: [
                if (countryProvider != null) Text('+${countryProvider.phoneCode}'),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: viewmodel.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'phone number'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: 90,
                child: CustomButton(
                    text: 'NEXT',
                    onPressed: () async {
                      final result = await viewmodel.sendPhoneNumber();

                      result.when(
                        loading: () => const Loader(),
                        data: (data) {
                          Navigator.of(context).pushNamed(Routes.OTPScreen);
                        },
                        error: (error) => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => WidgetError(
                                message: error.toString(), tryAgain: () async => await viewmodel.sendPhoneNumber()))),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
  // 1024015950