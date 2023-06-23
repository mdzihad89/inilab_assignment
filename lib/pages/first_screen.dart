import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final themeController = Get.find<ThemeController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (Get.isDarkMode) {
                themeController.changeThemeMode(ThemeMode.light);
                themeController.saveTheme(false);
              } else {
                themeController.changeThemeMode(ThemeMode.dark);
                themeController.saveTheme(true);
              }
            },
            child: const Text("Change Theme"),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
