import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';

class AzkarTextWidget extends StatelessWidget {
  const AzkarTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorsManger.lighterGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 16,
        children: [
          SvgPicture.asset(Assets.svgsAboveFrame),
          Text(
            "اللهم اجعل في قلبي نورًا، وفي بصري نورًا، وفي سمعي نورًا، وعن يميني نورًا، وعن يساري نورًا، وفوقي نورًا، وتحتي نورًا، وأمامي نورًا، وخلفي نورًا، واجعل لي نورًا.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SvgPicture.asset(Assets.svgsAboveFrame),
        ],
      ),
    );
  }
}
