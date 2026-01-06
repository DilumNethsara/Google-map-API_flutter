import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project2/mongodb.dart';

class DisplayMap extends StatefulWidget {
  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => _MapState();
}

class _MapState extends State<DisplayMap> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> myMarkers = {};

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(7.8731, 80.7718),
    zoom: 7,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    for (var i = 1; i <= 5; i++) {
      await fetchAndAddMarker(i);
    }
  }

  Future<void> fetchAndAddMarker(int prof_no) async {
    try {
      var data = await MongoDatabase.fetchByProfileId("profile_0$prof_no");
      if (data != null && data['coordinates'] != null) {
        double coordinate1 = data['coordinates'][0];
        double coordinate2 = data['coordinates'][1];

        setState(() {
          print('$coordinate1 cooorr $coordinate2');
          myMarkers.add(
            Marker(
              markerId: MarkerId("profile_0$prof_no"),
              position: LatLng(coordinate1, coordinate2),
              infoWindow: InfoWindow(
                title: "Profile $prof_no",
                snippet: "Location: $coordinate1, $coordinate2",
              ),
            ),
          );
        });
      } else {
        print('null');
      }
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Locations")),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: myMarkers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
