import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';

class AzkarTextWidget extends StatelessWidget {
  const AzkarTextWidget({super.key, required this.azkarText});
  final String azkarText;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorsManger.darkCard : ColorsManger.lighterGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 16,
        children: [
          SvgPicture.asset(Assets.svgsAboveFrame),
          Text(azkarText, style: Theme.of(context).textTheme.bodyMedium),
          SvgPicture.asset(Assets.svgsAboveFrame),
        ],
      ),
    );
  }
}
