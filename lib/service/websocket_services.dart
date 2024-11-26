import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'notification_services.dart';

class WebSocketService {
  final WebSocketChannel _channel;

  WebSocketService(String url)
      : _channel = WebSocketChannel.connect(Uri.parse(url));

  void listenForNotifications() {
    _channel.stream.listen((event) {
      final Map<String, dynamic> message = json.decode(event);

      if (message['title'] != null && message['body'] != null) {
        NotificationService.showNotification(message['title'], message['body']);
      }
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void dispose() {
    _channel.sink.close();
  }
}
