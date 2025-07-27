import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islamic_app/core/functions/notifications_service.dart';
import 'package:islamic_app/core/functions/work_manger_fun.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/bloc_observer.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/core/utils/dependency_injection.dart';
import 'package:islamic_app/features/notifications/data/repos/prayer_notification_service.dart';
import 'package:islamic_app/islamic_app.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await NotificationService.initialize();
  await PrayerNotificationService.scheduleDailyPrayerNotifications();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await registerPrayerNotificationTask();
  await intitHiveBoxs();
  setupServiceLocator();
  runApp(IslamicApp());
}

Future<void> intitHiveBoxs() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AzkarModelAdapter());
  Hive.registerAdapter(AzkarArrayAdapter());
  await Hive.openBox<AzkarModel>(azkarBox);
  await Hive.openBox<AzkarModel>(differerntAzkarBox);
  await Hive.openBox(themeBox);
  await Hive.openBox(audioBox);
}
