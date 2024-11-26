import 'package:permission_handler/permission_handler.dart';
import 'package:canvas_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screen/drawing_room_screen.dart';
import 'screen/test.dart';
import 'service/applifeclcyemanager.dart';
import 'service/notification_services.dart';
import 'service/websocket_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await requestNotificationPermission();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final webSocketService = WebSocketService('ws://localhost:3000/');
  webSocketService.listenForNotifications();
  runApp(
    AppLifecycleManager(
      webSocketService: webSocketService,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DrawingRoomScreen(),
    );
  }
}

Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }
}
