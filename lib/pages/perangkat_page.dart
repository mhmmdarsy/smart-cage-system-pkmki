import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/device_card.dart';
import '../widgets/page_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Pilih Perangkat',
            onBack: onBack,
            showNotification: false,
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DeviceCard(
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
                backgroundColor: AppColors.primaryBlue,
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
