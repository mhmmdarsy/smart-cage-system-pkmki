import 'package:flutter/material.dart';

import 'circle_icon.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.showNotification,
  });

  final String title;
  final VoidCallback onBack;
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIcon(icon: Icons.arrow_back_ios_new_rounded, onPressed: onBack),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
          ),
        ),
        if (showNotification)
          const CircleIcon(icon: Icons.notifications_none_rounded),
      ],
    );
  }
}
