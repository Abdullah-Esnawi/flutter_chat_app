import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/presentation/auth/viewmodel/auth_viewmodel.dart';

class OTPScreen extends ConsumerWidget {
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.read(authViewmodelProvider);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("We have sent an SMS with a code."),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(fontSize: 30),
                ),
                onChanged: (smsCode) {
                  if(smsCode.length == 6) {
                    debugPrint("Verifying OTP");
                    viewmodel.verifyOTP(context, verificationId, smsCode.trim()); // SMS Code == user OTP
                  }
                    debugPrint("Verify Function Was run");
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
