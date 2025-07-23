import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.title, required this.widget});
  final String title;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),

      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? ColorsManger.darkCard : ColorsManger.lightBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          widget,
        ],
      ),
    );
  }
}
