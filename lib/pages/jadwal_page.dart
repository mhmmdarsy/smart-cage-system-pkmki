import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/page_header.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
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
          PageHeader(
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
                      activeColor: AppColors.primaryBlue,
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
                backgroundColor: AppColors.primaryBlue,
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
