import 'package:flutter/material.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:share_plus/share_plus.dart';

class FavortieItem extends StatelessWidget {
  const FavortieItem({super.key, required this.text, required this.azkarArray});
  final String text;
  final AzkarArray azkarArray;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesDecorationBackgound),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
        border: Border.all(color: ColorsManger.grey, width: .1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              IconButton(
                iconSize: 30,
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(text: azkarArray.text ?? ''),
                  );
                },
                icon: Icon(Icons.share),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManger.darkBLue, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '${azkarArray.count ?? 0}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorsManger.darkBLue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
