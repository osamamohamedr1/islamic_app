import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';

class AzkarItem extends StatelessWidget {
  const AzkarItem({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  final String title;
  final String iconPath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.3, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 90.w,
          height: 90.h,
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkMode ? ColorsManger.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? ColorsManger.darkCard
                    : ColorsManger.lightGrey,
                offset: const Offset(0, 2.5),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconPath),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManger.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
