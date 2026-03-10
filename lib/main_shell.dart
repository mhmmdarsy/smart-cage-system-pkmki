import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/jadwal_page.dart';
import 'pages/perangkat_page.dart';
import 'theme/app_colors.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentTab = 0;
  int _selectedDevice = 0;
  final List<bool> _scheduleActive = [true, false, false];

  void _goToTab(int index) {
    setState(() => _currentTab = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(
        scheduleActive: _scheduleActive,
        onEditJadwalPressed: () => _goToTab(1),
        onScheduleChanged: (index, value) {
          setState(() {
            _scheduleActive[index] = value;
          });
        },
      ),
      JadwalPage(onBack: () => _goToTab(0)),
      PerangkatPage(
        selectedDevice: _selectedDevice,
        onBack: () => _goToTab(0),
        onDeviceChanged: (index) {
          setState(() => _selectedDevice = index);
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: _goToTab,
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
