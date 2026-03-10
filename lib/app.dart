import 'package:flutter/material.dart';

import 'main_shell.dart';
import 'theme/app_colors.dart';

class PetFeedApp extends StatelessWidget {
  const PetFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetFeed',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          surface: AppColors.scaffoldBackground,
        ),
      ),
      home: const MainShell(),
    );
  }
}
