import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';

class AllCustomContainer extends StatelessWidget {
  const AllCustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 1.3,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManger.primary, width: .4),
      ),
      child: Center(
        child: Text(
          'عبادات مختلفة',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
