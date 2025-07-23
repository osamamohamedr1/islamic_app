import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';

class ReciterDropdown extends StatelessWidget {
  final ReciterModel currentReciter;
  final Function(ReciterModel reciter) onChanged;

  const ReciterDropdown({
    super.key,
    required this.currentReciter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: DropdownButton<ReciterModel>(
        value: currentReciter,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        iconEnabledColor: ColorsManger.primary,

        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.black),
        isExpanded: true,
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
        items: reciters
            .map(
              (reciter) => DropdownMenuItem<ReciterModel>(
                value: reciter,
                child: Text(
                  reciter.nameAr,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: ColorsManger.primary),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
