import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/widgets/error.dart';
import 'package:whatsapp/core/resources/colors.dart';
import 'package:whatsapp/core/resources/widgets/custom_button.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/auth_viewmodel.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:whatsapp/generated/l10n.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen();

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Enter Your Phone number",
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(height: size.width * 0.6),
            SizedBox(
              width: 90,
              child: CustomButton(
                  text: 'NEXT',
                  onPressed: () {
                    viewmodel.sendPhoneNumber().then((state) {
                      if (state!.hasData) {
                        Navigator.of(context).pushNamed(Routes.OTPScreen);
                      } else {
                        WidgetError(message: S.of(context).somethingWentWrong);
                      }
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
