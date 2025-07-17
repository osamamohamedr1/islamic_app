import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
import 'package:islamic_app/core/utils/dependency_injection.dart';
import 'package:islamic_app/islamic_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initSharedPrefCaching();
  await ScreenUtil.ensureScreenSize();
  setupServiceLocator();
  runApp(IslamicApp());
}
