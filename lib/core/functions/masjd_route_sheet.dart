import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/find_nearest_masjd/presentation/manger/cubit/map_cubit.dart';

Future<dynamic> showMasjedRouteSheet(
  BuildContext context,
  String id,
  double lat,
  double lng,
  LatLng originLocation,
) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      String selectedMode = 'DRIVE';

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text('اختر طريقة السير', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ModeButton(
                      label: 'مشياً',
                      icon: Icons.directions_walk,
                      isSelected: selectedMode == 'TRAFFIC_AWARE',
                      onTap: () =>
                          setState(() => selectedMode = 'TRAFFIC_AWARE'),
                    ),
                    ModeButton(
                      label: 'بالسيارة',
                      icon: Icons.directions_car,
                      isSelected: selectedMode == 'DRIVE',
                      onTap: () => setState(() => selectedMode = 'DRIVE'),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ElevatedButton.icon(
                  icon: const Icon(Icons.alt_route),
                  onPressed: () {
                    context.read<MapCubit>().createRoute(
                      originLocation: originLocation,
                      destination: LatLng(lat, lng),
                      mode: 'DRIVE',
                    );
                    Navigator.pop(context);
                  },
                  label: const Text('عرض المسار'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

class ModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ModeButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? ColorsManger.primary : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      ),
    );
  }
}
