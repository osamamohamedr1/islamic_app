import 'package:flutter/material.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/core/utils/extensions.dart';
import 'package:islamic_app/features/choose_location/data/models/user_location_model.dart';

class ChooseLocationButton extends StatelessWidget {
  const ChooseLocationButton({
    super.key,
    required this.theme,
    required UserLocationModel? selectedLocation,
  }) : _selectedLocation = selectedLocation;

  final ThemeData theme;
  final UserLocationModel? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: theme.primaryColor,
      ),
      onPressed: () async {
        if (_selectedLocation != null) {
          await CacheHelper.saveData(
            key: locationName,
            value: _selectedLocation.arabicName,
          );
          await CacheHelper.saveData(
            key: locationLat,
            value: _selectedLocation.latitude,
          );
          await CacheHelper.saveData(
            key: locationLong,
            value: _selectedLocation.longitude,
          );
          context.pushNamedAndRemoveUntil(
            Routes.bottomNavBar,
            predicate: (route) => true,
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('يرجى اختيار موقع')));
        }
      },
      icon: const Icon(Icons.check, color: Colors.white),
      label: const Text(
        'تأكيد الموقع',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
