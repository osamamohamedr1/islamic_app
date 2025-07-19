import 'package:flutter/material.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/azkar_actions.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/azkar_text_widget.dart';

class DuaItem extends StatelessWidget {
  final Array azkarArray;
  const DuaItem({super.key, required this.azkarArray});

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
        children: [
          AzkarTextWidget(azkarText: azkarArray.text ?? ''),
          AzkarActionsWidget(azkarArray: azkarArray),
        ],
      ),
    );
  }
}
