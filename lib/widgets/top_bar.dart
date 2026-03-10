import 'package:flutter/material.dart';

import 'circle_icon.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF3B6FA3),
              fontSize: 56,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const CircleIcon(icon: Icons.notifications_none_rounded),
      ],
    );
  }
}
