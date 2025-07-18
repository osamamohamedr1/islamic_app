import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/azkar_actions.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/azkar_text_widget.dart';

class DuaItem extends StatelessWidget {
  const DuaItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorsManger.lighterGrey,
            offset: Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: ColorsManger.lighterGrey, width: .4),
      ),
      child: Column(
        spacing: 4,
        children: [AzkarTextWidget(), AzkarActionsWidget()],
      ),
    );
  }
}
