import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/find_nearest_masjd/presentation/manger/cubit/map_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:ui' as ui;

class FindNearestMasjdView extends StatefulWidget {
  const FindNearestMasjdView({super.key});

  @override
  State<FindNearestMasjdView> createState() => _FindNearestMasjdViewState();
}

class _FindNearestMasjdViewState extends State<FindNearestMasjdView> {
  GoogleMapController? _controller;
  late CameraPosition initialCameraPosition;
  bool isFristCall = true;

  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) async {
        if (state is MapLocationLoaded) {
          _controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: state.location, zoom: 17),
            ),
          );

          markers.add(
            Marker(position: state.location, markerId: MarkerId('myLocation')),
          );
          context.read<MapCubit>().getNearbyPLaces(location: state.location);
        }

        if (state is LiveLocationUpdate) {
          final Uint8List markerIcon = await getBytesFromAsset(
            Assets.imagesManMarker,
            150,
          );

          if (isFristCall) {
            Future.delayed(Duration(milliseconds: 200), () {
              _controller?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: state.location, zoom: 17),
                ),
              );
            });

            markers.add(
              Marker(
                icon: BitmapDescriptor.bytes(markerIcon),
                position: state.location,
                markerId: MarkerId('myLiveLocation'),
              ),
            );
            setState(() {});
            isFristCall = false;
          } else {
            _controller?.animateCamera(CameraUpdate.newLatLng(state.location));

            markers.add(
              Marker(
                icon: BitmapDescriptor.bytes(markerIcon),
                position: state.location,
                markerId: MarkerId('myLiveLocation'),
              ),
            );
            setState(() {});
          }
        }

        if (state is GetNearestMasjd) {
          final Uint8List masjdIcon = await getBytesFromAsset(
            Assets.imagesMasjdMarker,
            60,
          );
          log(state.masjds[0].displayName?.text ?? '');

          Set<Marker> masjdMarkers = state.masjds.map((masjd) {
            final id = masjd.displayName?.text ?? "unknown";
            final lat = masjd.location?.latitude ?? 0.0;
            final lng = masjd.location?.longitude ?? 0.0;

            return Marker(
              markerId: MarkerId(id),
              icon: BitmapDescriptor.bytes(masjdIcon),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: id),
            );
          }).toSet();
          markers.addAll(masjdMarkers);
          setState(() {});
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is MapLoacationLoading,
          child: GoogleMap(
            onMapCreated: (controller) {
              _controller = controller;

              context.read<MapCubit>().getLocation();
            },
            zoomControlsEnabled: false,
            markers: markers,
            initialCameraPosition: initialCameraPosition,
          ),
        );
      },
    );
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(
    format: ui.ImageByteFormat.png,
  ))!.buffer.asUint8List();
}
