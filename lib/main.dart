import 'package:canvas_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screen/drawing_room_screen.dart';
import 'service/applifeclcyemanager.dart';
import 'service/notification_services.dart';
import 'service/websocket_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final webSocketService = WebSocketService('http://localhost:3000/');
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
