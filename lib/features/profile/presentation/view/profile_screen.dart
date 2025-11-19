import 'package:catalog/core/shared/widgets/custom_app_bar.dart';
import 'package:catalog/features/profile/presentation/widgets/theme_switch_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: CustomAppBar(title: 'Профиль'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ThemeSwitchTile(),
          ],
        ),
      ),
    );
  }
}

