import 'package:flutter/material.dart';

import '../models/schedule_item.dart';
import '../theme/app_colors.dart';
import '../widgets/schedule_tile.dart';
import '../widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.scheduleActive,
    required this.onScheduleChanged,
    required this.onEditJadwalPressed,
    required this.onFeedNow,
  });

  final List<bool> scheduleActive;
  final void Function(int index, bool value) onScheduleChanged;
  final VoidCallback onEditJadwalPressed;
  final Future<void> Function() onFeedNow;

  static const _schedules = <ScheduleItem>[
    ScheduleItem(
      name: 'Makan Pagi',
      time: '08:00',
      icon: Icons.wb_sunny_rounded,
      iconBgColor: Color(0xFFF4E8AF),
      iconColor: Color(0xFFD79A00),
    ),
    ScheduleItem(
      name: 'Makan Siang',
      time: '12:00',
      icon: Icons.wb_sunny,
      iconBgColor: Color(0xFFF3E1C7),
      iconColor: Color(0xFFEE5D12),
    ),
    ScheduleItem(
      name: 'Makan Malam',
      time: '20:00',
      icon: Icons.bedtime_rounded,
      iconBgColor: Color(0xFFC9D8EE),
      iconColor: Color(0xFF2D63E3),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBar(title: 'PetFeed'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 96,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 2,
              ),
              onPressed: () async {
                await onFeedNow();
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Perintah pakan dikirim (dummy IoT service).',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.restaurant, size: 36),
              label: const Text(
                'Beri Pakan Sekarang',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Jadwal',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onEditJadwalPressed,
                child: const Text(
                  'Edit Jadwal',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _schedules.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ScheduleTile(
                name: _schedules[i].name,
                time: _schedules[i].time,
                icon: _schedules[i].icon,
                iconBgColor: _schedules[i].iconBgColor,
                iconColor: _schedules[i].iconColor,
                value: scheduleActive[i],
                onChanged: (value) => onScheduleChanged(i, value),
              ),
            ),
        ],
      ),
    );
  }
}
