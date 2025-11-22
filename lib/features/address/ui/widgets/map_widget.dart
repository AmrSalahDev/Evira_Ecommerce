import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/constants/app_colors.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/features/address/ui/bloc/address_bloc.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;

  const MapWidget({super.key, required this.initialPosition});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late MapController _mapController;
  late LatLng _currentPosition;
  final List<Marker> _markers = [];
  bool isUserWithoutImage = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _currentPosition = widget.initialPosition;
    context.read<AddressBloc>().add(
      GetCurrentAddressDetailsEvent(_currentPosition),
    );
    _addMarker(_currentPosition);
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          point: position,
          width: 40.h,
          height: 40.h,
          child: isUserWithoutImage
              ? Icon(Icons.location_on, color: AppColors.darkCard, size: 50.h)
              : Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Assets.icons.locationPin.svg(
                        colorFilter: ColorFilter.mode(
                          AppColors.darkCard,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -2,
                      left: 2,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: 35.h,
                          height: 35.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => ShimmerBox(
                            height: 35.h,
                            width: 35.h,
                            borderRadius: 100,
                          ),
                          errorListener: (error) {
                            setState(() {
                              isUserWithoutImage = true;
                            });
                          },
                          imageUrl:
                              Supabase
                                  .instance
                                  .client
                                  .auth
                                  .currentUser!
                                  .userMetadata!['profileImage'] ??
                              '',
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentPosition,
        initialZoom: 15.0,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),

        onTap: (tapPosition, point) async {
          setState(() {
            _currentPosition = point;
          });
          _addMarker(point);
          context.read<AddressBloc>().add(GetCurrentAddressDetailsEvent(point));
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.blackcode.evira',
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
