import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController{
  final _box=GetStorage();
  final _key="isDark";
  ThemeMode get theme=>_loadTheme()?ThemeMode.dark:ThemeMode.light;
  bool _loadTheme()=>_box.read(_key)??false;
  void saveTheme(bool isDarkMode)=>_box.write(_key, isDarkMode);
  void changeTheme(ThemeData themeData)=>Get.changeTheme(themeData);
  void changeThemeMode(ThemeMode themeMode)=>Get.changeThemeMode(themeMode);
}