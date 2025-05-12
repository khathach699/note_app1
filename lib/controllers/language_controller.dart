import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var locale = Rx<Locale>(Locale('vi'));

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void changeLanguage(String languageCode) async {
    locale.value = Locale(languageCode);
    Get.updateLocale(Locale(languageCode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  void loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language') ?? 'en';
    locale.value = Locale(savedLanguage);
    Get.updateLocale(Locale(savedLanguage));
  }
}
