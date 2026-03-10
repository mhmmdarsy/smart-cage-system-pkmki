import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_shell.dart';
import 'services/fake_petfeed_service.dart';
import 'state/petfeed_controller.dart';
import 'theme/app_colors.dart';

class PetFeedApp extends StatelessWidget {
  const PetFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PetFeedController(service: FakePetFeedService()),
      child: MaterialApp(
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
      ),
    );
  }
}
