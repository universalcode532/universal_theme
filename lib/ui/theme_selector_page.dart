import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';
import '../theme/app_theme.dart';

class ThemeSelectorPage extends StatelessWidget {
  final ThemeController controller = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colors = controller.colors;
      return Scaffold(
        appBar: AppBar(title: const Text('Choose Theme')),
        backgroundColor: colors.background,
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: AppTheme.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (_, index) {
            final theme = AppTheme.values[index];
            return GestureDetector(
              onTap: () => controller.changeTheme(theme),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.lightColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text(theme.name)),
              ),
            );
          },
        ),
      );
    });
  }
}
