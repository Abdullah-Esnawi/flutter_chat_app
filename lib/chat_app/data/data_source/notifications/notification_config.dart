import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/resources/routes_manager.dart';
import 'package:http/http.dart' as http;

final firebaseMessagingToken = StateProvider((ref) => '');

final notificationsConfigProvider = Provider((ref) => NotificationsConfig(ref));

class NotificationsConfig {
  final ProviderRef ref;

  NotificationsConfig(this.ref);

  Future<void> requestPermission() async {
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

  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
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

  sendNotification({required String title, body, to, profilePic}) async {
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
            "to": ref.watch(firebaseMessagingToken.notifier).state,
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "basic",
              'image': profilePic,
            },
            "data": <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'image': profilePic,
              "url": profilePic,
            }
          },
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

//   _incrementCounter() {
//     // setState(() {
//     //   _counter++;
//     // });
//     sendNotification(
//       title:  'Hi ',
//        body:AboutDialog() 'increment : ',
//      to:  to,
//      profilePic:  profilePic  );
//   }
}
