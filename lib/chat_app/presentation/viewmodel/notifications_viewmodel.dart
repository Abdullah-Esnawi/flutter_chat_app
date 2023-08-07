import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:http/http.dart' as http;

final firebaseMessagingToken = StateProvider.autoDispose((ref) => '');

class NotificationsViewmodel {
  final Ref ref;

  NotificationsViewmodel(this.ref);

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    ref.read(firebaseMessagingToken.notifier).update((state) => token ?? '');
  }

  initInfo(BuildContext context, FlutterLocalNotificationsPlugin localNotiPlugin) async {
    // Local Notification Setup
    const androidInit = AndroidInitializationSettings('@mipmap/icon_launcher');

    final iosInit = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

    localNotiPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        debugPrint('${notificationResponse.notificationResponseType}.');

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            debugPrint('${notificationResponse.payload}');
            Navigator.pushNamed(context, Routes.ChatScreen, arguments: {}); //
            break;
          case NotificationResponseType.selectedNotificationAction:
            print(notificationResponse);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Action')),
                ),
              ),
            );
            break;
        }
      },
    );
  }


  sendNotification(String title, body, to, icon) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAerc3lr8:APA91bH5l14LsnfkTd3W9pUEsbBUfzx7WwCxBFAkddm5x1imNspWf4qsLlpBAnwx7MXx4OB95Nz_wGbO-vm1Ee10C4DoYYZLtIEL5eA6TNUelc9nT_EU9rvvk7qz8GLqJyCgfqVp8FVh",
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            "to": to,
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "basic",
              'image': icon,
            },
            "data": <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'image': icon,
              "url": icon,
            }
          },
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    sendNotification(
        'Hi ',
        'increment : ',
        'di8HrFY-RYimn6xLCmc_bk:APA91bFRFAMP8BYC5EanPYfpjL3-dNzT-unw205xeHLzs29oUuN2gffOswRrTxVkl1GTMx_Hy0sXCmInNk6B52v_zL63CPERGwz9-0DVEM9U90XaMWAbHtcIlEUZ0sxp9Y0actzqi7bJ',
        'https://images.unsplash.com/photo-1688607932382-f01b0987c897?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=988&q=80');
  }




}
