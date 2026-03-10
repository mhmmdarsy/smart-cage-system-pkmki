import 'package:flutter/material.dart';

class ScheduleItem {
  const ScheduleItem({
    required this.name,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  final String name;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
}
