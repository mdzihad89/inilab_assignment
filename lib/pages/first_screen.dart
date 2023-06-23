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
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


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
      body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter github user name';
                }
              },
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your username ',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white60,
                  fixedSize:
                  Size(MediaQuery.of(context).size.width * 0.5, 30)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.toNamed('/home', arguments: nameController.text.trim().toString());
                  nameController.clear();
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
