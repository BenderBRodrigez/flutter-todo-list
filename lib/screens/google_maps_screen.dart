import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MarkerIconsBody();
  }
}

class MarkerIconsBody extends StatefulWidget {
  const MarkerIconsBody();

  @override
  State<StatefulWidget> createState() => MarkerIconsBodyState();
}

const LatLng _kMapCenter = LatLng(52.4478, -3.5402);

class MarkerIconsBodyState extends State<MarkerIconsBody> {
  GoogleMapController controller;
  bool _myLocationEnabled = true;
  bool _myLocationButtonEnabled = true;
  bool _isMapCreated = false;

  @override
  Widget build(BuildContext context) {
    setPermissions();

    final GoogleMap googleMap = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: _kMapCenter,
        zoom: 7.0,
      ),
      myLocationEnabled: _myLocationEnabled,
      myLocationButtonEnabled: _myLocationButtonEnabled,
      zoomControlsEnabled: false,
    );

    final List<Widget> columnChildren = <Widget>[
      Center(
        child: SizedBox(
//          width: 300.0,
          height: 300.0,
          child: googleMap,
        ),
      ),
    ];

    if (_isMapCreated) {
      columnChildren.addAll([
        _myLocationToggler(),
        _myLocationButtonToggler(),
      ]);
    }

    return Scaffold(
      appBar: AppBar(title: Text('map')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren.reversed.toList(),
      ),
    );
  }

  void setPermissions() async {
    PermissionStatus permissions = await Permission.location.request();
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _isMapCreated = true;
    });
  }

  Widget _myLocationToggler() {
    return FlatButton(
      child: Text(
          '${_myLocationEnabled ? 'disable' : 'enable'} my location'),
      onPressed: () {
        setState(() {
          _myLocationEnabled = !_myLocationEnabled;
        });
      },
    );
  }

  Widget _myLocationButtonToggler() {
    return FlatButton(
      child: Text(
          '${_myLocationButtonEnabled ? 'disable' : 'enable'} my location button'),
      onPressed: () {
        setState(() {
          _myLocationButtonEnabled = !_myLocationButtonEnabled;
        });
      },
    );
  }

}