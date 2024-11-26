import 'package:flutter/material.dart';

import '../service/notification_services.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () =>
                NotificationService.showNotification('Test Title', 'Test Body'),
            child: Text('Notification')),
      ),
    );
  }
}
