import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app1/controllers/language_controller.dart';
import 'package:note_app1/generated/app_localizations.dart';
import 'package:note_app1/screens/note_Screens.dart';
import 'package:note_app1/screens/sign_in_screen.dart';
import 'package:note_app1/screens/sign_up_screen.dart';

class MyApp extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true, // adapt text size to screen size
      splitScreenMode: true, // support for split screen mode
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Note App",
            locale: languageController.locale.value,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(primaryColor: Colors.blue),
            initialRoute: "/sign-in",
            getPages: [
              GetPage(name: '/home', page: () => NoteScreens()),
              GetPage(name: '/sign-in', page: () => SignInScreen()),
              GetPage(name: '/sign-up', page: () => SignUpScreen()),
            ],
          ),
        );
      },
    );
  }
}
