import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/pages/first_screen.dart';
import 'package:inilabs_assignment/pages/home_page.dart';
import 'controller/theme_controller.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final themeController=Get.put(ThemeController());
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      themeMode: themeController.theme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FirstScreen()),
        GetPage(
          name: '/home',
          page: () => HomePage(username: Get.arguments),
        ),
      ],
    );
  }
}
