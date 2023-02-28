import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const id = 'notification_screen';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RemoteNotification?> notifications =
        ModalRoute.of(context)!.settings.arguments as List<RemoteNotification?>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('There is no data'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                if (notifications[index] != null) {
                  // RemoteNotification notification = notifications[index];
                  return ListTile(
                    title: Text('${notifications[index]?.title}'),
                    subtitle: Text('${notifications[index]?.body}'),
                  );
                }
                return const SizedBox();
              }),
    );
  }
}
