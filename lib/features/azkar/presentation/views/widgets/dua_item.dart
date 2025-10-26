import 'package:flutter/material.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/azkar/presentation/views/widgets/azkar_actions.dart';
import 'package:islamic_app/features/azkar/presentation/views/widgets/azkar_text_widget.dart';

class DuaItem extends StatelessWidget {
  final AzkarArray azkarArray;
  final void Function() onToggleFavorite;
  const DuaItem({
    super.key,
    required this.azkarArray,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? ColorsManger.darkCard
                : ColorsManger.lighterGrey,
            offset: Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: ColorsManger.grey, width: .2),
      ),
      child: Column(
        spacing: 4,
        children: [
          AzkarTextWidget(azkarText: azkarArray.text ?? ''),
          AzkarActionsWidget(
            azkarArray: azkarArray,
            onToggleFavorite: onToggleFavorite,
          ),
        ],
      ),
    );
  }
}
