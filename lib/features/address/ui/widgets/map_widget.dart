import 'package:evira_e_commerce/features/address/ui/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    _addMarker(_currentPosition);
    context.read<AddressBloc>().add(
      GetCurrentAddressDetailsEvent(_currentPosition),
    );
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          point: position,
          width: 80,
          height: 80,
          child: Icon(Icons.location_on, color: Colors.blue, size: 40),
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
