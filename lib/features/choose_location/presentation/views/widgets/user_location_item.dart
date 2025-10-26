import 'package:flutter/material.dart';
import 'package:islamic_app/features/choose_location/data/models/user_location_model.dart';

class UserLocationItem extends StatelessWidget {
  const UserLocationItem({
    super.key,
    required this.isSelected,
    required this.theme,
    required this.city,
  });

  final bool isSelected;
  final ThemeData theme;
  final UserLocationModel city;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? theme.primaryColor : Colors.grey.shade300,
          width: .5,
        ),
      ),
      color: isSelected ? theme.primaryColorLight : Colors.white,
      child: ListTile(
        title: Text(
          city.arabicName,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isSelected ? theme.primaryColor : Colors.black,
          ),
        ),
        subtitle: Text(
          city.governorate,
          style: TextStyle(
            color: isSelected ? theme.primaryColor : Colors.grey,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
      ),
    );
  }
}
