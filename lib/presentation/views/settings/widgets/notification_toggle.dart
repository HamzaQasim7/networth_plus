import 'package:flutter/material.dart';

class NotificationToggle extends StatefulWidget {
  const NotificationToggle({super.key});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _enabled,
      onChanged: (value) {
        setState(() {
          _enabled = value;
        });
        // TODO: Implement notification toggle logic
      },
    );
  }
} 