// ignore_for_file: unused_field

import 'dart:typed_data';

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
        }

        if (state is LiveLocationUpdate) {
          var icon = await BitmapDescriptor.asset(
            ImageConfiguration(),
            Assets.imagesMasjdMarker,
          );

          final Uint8List markerIcon = await getBytesFromAsset(
            Assets.imagesMasjdMarker,
            150,
          );

          if (isFristCall) {
            _controller?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: state.location, zoom: 15),
              ),
            );

            markers.add(
              Marker(
                icon: BitmapDescriptor.fromBytes(markerIcon),
                position: state.location,
                markerId: MarkerId('myLiveLocation'),
              ),
            );
            isFristCall = false;
          } else {
            _controller?.animateCamera(CameraUpdate.newLatLng(state.location));

            markers.add(
              Marker(
                icon: BitmapDescriptor.fromBytes(markerIcon),
                position: state.location,
                markerId: MarkerId('myLiveLocation'),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is MapLoacationLoading,
          child: GoogleMap(
            onMapCreated: (controller) {
              _controller = controller;

              context.read<MapCubit>().getLiveLocation();
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
