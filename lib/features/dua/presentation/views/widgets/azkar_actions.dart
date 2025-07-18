import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/favorite_animated_button.dart';

class AzkarActionsWidget extends StatelessWidget {
  const AzkarActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        IconButton(iconSize: 26, onPressed: () {}, icon: Icon(Icons.share)),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManger.darkBLue, width: 1.5),
          ),
          child: Text(
            '1',
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: ColorsManger.darkBLue),
          ),
        ),
        SizedBox(height: 60, width: 60, child: FavoriteAnimatedButton()),
      ],
    );
  }
}
