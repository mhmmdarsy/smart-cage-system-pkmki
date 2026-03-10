import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/jadwal_page.dart';
import 'pages/perangkat_page.dart';
import 'state/petfeed_controller.dart';
import 'theme/app_colors.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PetFeedController>();

    final pages = <Widget>[
      HomePage(
        scheduleActive: controller.scheduleActive,
        onEditJadwalPressed: () => controller.setTab(1),
        onScheduleChanged: controller.updateScheduleActive,
        onFeedNow: controller.triggerFeedNow,
      ),
      JadwalPage(onBack: () => controller.setTab(0)),
      PerangkatPage(
        selectedDevice: controller.selectedDevice,
        onBack: () => controller.setTab(0),
        onDeviceChanged: controller.selectDevice,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[controller.currentTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentTab,
        onTap: controller.setTab,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: const Color(0xFFB7B7BC),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'BERANDA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'JADWAL',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'PERANGKAT',
          ),
        ],
      ),
    );
  }
}
