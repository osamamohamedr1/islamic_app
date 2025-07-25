import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,

    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              id,

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.directions, size: 26),
                  onPressed: () {
                    context.read<MapCubit>().createRoute(
                      originLocation: originLocation,
                      destination: LatLng(lat, lng),
                    );
                    Navigator.pop(context);
                  },
                  label: Text(
                    'عرض المسار',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
