import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindNearestMasjdView extends StatefulWidget {
  const FindNearestMasjdView({super.key});

  @override
  State<FindNearestMasjdView> createState() => _FindNearestMasjdViewState();
}

class _FindNearestMasjdViewState extends State<FindNearestMasjdView> {
  late GoogleMapController _controller;
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(
      target: LatLng(31, 31),
      zoom: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (controller) {
        _controller = controller;
      },
    );
  }
}
