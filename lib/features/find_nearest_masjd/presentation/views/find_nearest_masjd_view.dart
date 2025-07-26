import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/core/functions/get_lat_lang_bounds.dart';
import 'package:islamic_app/core/functions/marker_resizer_fun.dart';
import 'package:islamic_app/core/functions/masjd_route_sheet.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/find_nearest_masjd/presentation/manger/cubit/map_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FindNearestMasjdView extends StatefulWidget {
  const FindNearestMasjdView({super.key});

  @override
  State<FindNearestMasjdView> createState() => _FindNearestMasjdViewState();
}

class _FindNearestMasjdViewState extends State<FindNearestMasjdView> {
  GoogleMapController? _controller;
  late CameraPosition initialCameraPosition;
  bool isFristCall = true;
  LatLng originLocation = LatLng(0, 0);
  int polylineId = 0;

  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) async {
          if (state is LocationLoaded) {
            final Uint8List originalLocationMarker = await getBytesFromAsset(
              Assets.imagesCurrentLocationMarker,
              55,
            );
            _controller?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: state.location, zoom: 17),
              ),
            );

            var myCurrentLocationMarker = Marker(
              icon: BitmapDescriptor.bytes(originalLocationMarker),
              position: state.location,
              markerId: MarkerId('myLocation'),
            );

            originLocation = state.location;
            context.read<MapCubit>()
              ..clearMarkers()
              ..addMarker(myCurrentLocationMarker)
              ..getNearbyPLaces(location: state.location);
          }

          if (state is LiveLocationUpdate) {
            final liveMarker = Marker(
              markerId: const MarkerId('myLiveLocation'),
              position: state.location,
            );

            context.read<MapCubit>().replaceMarker(
              'myLiveLocation',
              liveMarker,
            );

            _controller?.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(state.location.latitude, state.location.longitude),
              ),
            );
          }

          if (state is GetNearestMasjd) {
            final masjdIcon = await getBytesFromAsset(
              Assets.imagesMasjdMarker,
              48,
            );

            final masjdMarkers = state.masjds.map((masjd) {
              final id = masjd.displayName?.text ?? "unknown";
              final lat = masjd.location?.latitude ?? 0.0;
              final lng = masjd.location?.longitude ?? 0.0;

              return Marker(
                markerId: MarkerId(id),
                position: LatLng(lat, lng),
                icon: BitmapDescriptor.bytes(masjdIcon),
                infoWindow: InfoWindow(title: id),
                onTap: () {
                  showMasjedRouteSheet(context, id, lat, lng, originLocation);
                },
              );
            }).toSet();

            context.read<MapCubit>().addMarkers(masjdMarkers);
          }

          if (state is RouteCreated) {
            context.read<MapCubit>().setPolylines({
              Polyline(
                polylineId: const PolylineId('masjdRoute'),
                points: state.points,
                color: Colors.black,
                width: 5,
              ),
            });
            _controller?.animateCamera(
              CameraUpdate.newLatLngBounds(getLatLangBounds(state.points), 40),
            );
          }

          if (state is MapError) {
            ScaffoldMessenger.of(
              // ignore: use_build_context_synchronously
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final mapCubit = context.read<MapCubit>();
          return ModalProgressHUD(
            inAsyncCall:
                state is MapLoacationLoading ||
                state is FindNearestMasjdLoading ||
                state is CreateRouteLoading,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _controller = controller;

                    context.read<MapCubit>().getLocation();
                  },
                  zoomControlsEnabled: false,
                  markers: mapCubit.markers,
                  polylines: mapCubit.polylines,
                  initialCameraPosition: initialCameraPosition,
                ),

                Positioned(
                  top: 50,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: ColorsManger.darkBLue,
                    radius: 25,
                    child: IconButton(
                      tooltip: 'أقرب مسجد',
                      onPressed: () {
                        final cubit = context.read<MapCubit>();

                        cubit
                          ..cancelLiveLocationUpdates()
                          ..getLocation()
                          ..clearMarkers()
                          ..clearPolylines();
                      },

                      icon: Icon(Icons.mosque, size: 30),
                    ),
                  ),
                ),

                Positioned(
                  top: 110,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: ColorsManger.darkBLue,
                    radius: 25,
                    child: IconButton(
                      tooltip: 'تتبع السير',
                      onPressed: () {
                        context.read<MapCubit>().getLiveLocation();
                      },

                      icon: Icon(Icons.assistant_navigation, size: 30),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
