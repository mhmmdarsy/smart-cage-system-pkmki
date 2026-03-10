import 'package:flutter/material.dart';

void main() {
  runApp(const PetFeedApp());
}

class PetFeedApp extends StatelessWidget {
  const PetFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetFeed',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F2F4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B6FA3),
          surface: const Color(0xFFF2F2F4),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _primaryBlue = Color(0xFF3B6FA3);

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
        selectedItemColor: _primaryBlue,
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

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.scheduleActive,
    required this.onScheduleChanged,
    required this.onEditJadwalPressed,
  });

  final List<bool> scheduleActive;
  final void Function(int index, bool value) onScheduleChanged;
  final VoidCallback onEditJadwalPressed;

  static const _primaryBlue = Color(0xFF3B6FA3);

  @override
  Widget build(BuildContext context) {
    final schedules = [
      (
        name: 'Makan Pagi',
        time: '08:00',
        icon: Icons.wb_sunny_rounded,
        bg: const Color(0xFFF4E8AF),
        iconColor: const Color(0xFFD79A00),
      ),
      (
        name: 'Makan Siang',
        time: '12:00',
        icon: Icons.wb_sunny,
        bg: const Color(0xFFF3E1C7),
        iconColor: const Color(0xFFEE5D12),
      ),
      (
        name: 'Makan Malam',
        time: '20:00',
        icon: Icons.bedtime_rounded,
        bg: const Color(0xFFC9D8EE),
        iconColor: const Color(0xFF2D63E3),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TopBar(title: 'PetFeed'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 96,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 2,
              ),
              onPressed: () {},
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
                  backgroundColor: _primaryBlue,
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
          for (int i = 0; i < schedules.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ScheduleTile(
                name: schedules[i].name,
                time: schedules[i].time,
                icon: schedules[i].icon,
                iconBgColor: schedules[i].bg,
                iconColor: schedules[i].iconColor,
                value: scheduleActive[i],
                onChanged: (value) => onScheduleChanged(i, value),
              ),
            ),
        ],
      ),
    );
  }
}

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  static const _primaryBlue = Color(0xFF3B6FA3);

  int _hour = 8;
  int _minute = 0;
  bool _isActive = true;
  final _namaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            title: 'Edit Jadwal',
            onBack: widget.onBack,
            showNotification: true,
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Pilih Waktu',
              style: TextStyle(
                fontSize: 34,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timePickerBox(
                value: _hour.toString().padLeft(2, '0'),
                onPressed: () {
                  setState(() => _hour = (_hour + 1) % 24);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  ':',
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w700),
                ),
              ),
              _timePickerBox(
                value: _minute.toString().padLeft(2, '0'),
                onPressed: () {
                  setState(() => _minute = (_minute + 5) % 60);
                },
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: 'Isi disini . . .',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Aktifkan Jadwal ?',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Switch(
                      value: _isActive,
                      activeColor: _primaryBlue,
                      onChanged: (value) => setState(() => _isActive = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 82,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Jadwal disimpan (dummy frontend).'),
                  ),
                );
              },
              icon: const Icon(Icons.check, size: 40),
              label: const Text(
                'Simpan',
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePickerBox({
    required String value,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: SizedBox(
          width: 110,
          height: 130,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class PerangkatPage extends StatelessWidget {
  const PerangkatPage({
    super.key,
    required this.selectedDevice,
    required this.onDeviceChanged,
    required this.onBack,
  });

  final int selectedDevice;
  final ValueChanged<int> onDeviceChanged;
  final VoidCallback onBack;

  static const _primaryBlue = Color(0xFF3B6FA3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            title: 'Pilih Perangkat',
            onBack: onBack,
            showNotification: false,
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _DeviceCard(
                title: 'Kandang ${i + 1}',
                selected: selectedDevice == i,
                onSelect: () => onDeviceChanged(i),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 82,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Kandang ${selectedDevice + 1} dipilih (dummy frontend).',
                    ),
                  ),
                );
              },
              child: const Text(
                'Konfirmasi Pilihan',
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title});

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
        const _CircleIcon(icon: Icons.notifications_none_rounded),
      ],
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
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
        _CircleIcon(icon: Icons.arrow_back_ios_new_rounded, onPressed: onBack),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
          ),
        ),
        if (showNotification)
          const _CircleIcon(icon: Icons.notifications_none_rounded),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Colors.white.withValues(alpha: 0.95),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(width: 74, height: 74, child: Icon(icon, size: 40)),
      ),
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({
    required this.name,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.value,
    required this.onChanged,
  });

  final String name;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 42),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF3B6FA3),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.title,
    required this.selected,
    required this.onSelect,
  });

  final String title;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? const Color(0xFF3B6FA3) : Colors.black26,
          width: selected ? 2.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 130,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selected
                        ? const Color(0xFF3B6FA3)
                        : const Color(0xFFF0F0F0),
                foregroundColor:
                    selected ? Colors.white : const Color(0xFF3B6FA3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onSelect,
              child: Text(
                selected ? 'Terpilih' : 'Pilih',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
