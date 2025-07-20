import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/core/utils/dependency_injection.dart';
import 'package:islamic_app/islamic_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initSharedPrefCaching();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();

  Hive.registerAdapter(AzkarModelAdapter());
  Hive.registerAdapter(ArrayAdapter());
  await Hive.openBox<AzkarModel>(azkarBox);

  setupServiceLocator();
  runApp(IslamicApp());
}
