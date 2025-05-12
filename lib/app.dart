import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app1/controllers/language_controller.dart';
import 'package:note_app1/generated/app_localizations.dart';
import 'package:note_app1/screens/note_Screens.dart';

class MyApp extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: "Note App",
        locale: languageController.locale.value,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(primaryColor: Colors.blue),
        home: NoteScreens(),
      ),
    );
  }
}
