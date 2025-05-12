import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app1/app.dart';
import 'package:note_app1/firebase_options.dart';
import 'package:note_app1/services/NotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationService = NotificationService();
  await notificationService.initialize();
  final token = await NotificationService().getFcmToken();
  print('FCM Token: $token');
  runApp(MyApp());
}
