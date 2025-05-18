import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Notification',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF303548),
          fontSize: 24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      )),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: const Column(
          children: [
            Text(
              'Mark all as read',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0053D2),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
