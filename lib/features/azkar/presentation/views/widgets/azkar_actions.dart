import 'package:flutter/material.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/widgets/favorite_animated_button.dart';
import 'package:share_plus/share_plus.dart';

class AzkarActionsWidget extends StatelessWidget {
  const AzkarActionsWidget({
    super.key,
    required this.azkarArray,
    required this.onToggleFavorite,
  });
  final Array azkarArray;
  final void Function() onToggleFavorite;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        IconButton(
          iconSize: 26,
          onPressed: () {
            SharePlus.instance.share(ShareParams(text: azkarArray.text ?? ''));
          },
          icon: Icon(Icons.share),
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManger.darkBLue, width: 1.5),
          ),
          child: Text(
            '${azkarArray.count ?? 0}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: ColorsManger.darkBLue),
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: FavoriteAnimatedButton(
            onToggleFavorite: onToggleFavorite,
            isFavorite: azkarArray.isFavorite,
            index: (azkarArray.id! - 1),
          ),
        ),
      ],
    );
  }
}
