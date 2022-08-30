
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/map_data.dart';
import 'package:station_google_map/data/map_data.dart' as station;
class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices1 = await station.getGoogleOffices2();
    setState(() {
      _markers.clear();
      for (final office in googleOffices1.offices1!) {
        final marker = Marker(
          markerId: MarkerId(office.fullSectDist),
          position: LatLng(double.parse(office.gpsY), double.parse(office.gpsX)),
        );
        _markers[office.fullSectDist] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Bus 정류장 위치'),
          backgroundColor: Colors.blue[700],
          centerTitle: true,
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(37.61454,126.917729),
            zoom: 14,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
