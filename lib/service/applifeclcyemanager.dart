import 'package:flutter/material.dart';
import 'websocket_services.dart'; // Import your WebSocketService

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  final WebSocketService webSocketService;

  const AppLifecycleManager({
    required this.child,
    required this.webSocketService,
    Key? key,
  }) : super(key: key);

  @override
  _AppLifecycleManagerState createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      widget.webSocketService.sendMessage('{"status": "background"}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
