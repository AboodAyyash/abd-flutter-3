import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.9244572, 35.9685925),
    zoom: 14,
  );
  static const CameraPosition _kLake =
      CameraPosition(target: LatLng(31.9244572, 35.9685925), zoom: 14);

  Set<Marker> mainMarkers = const <Marker>{};
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarkers();
    addPolyLine();
  }

  getMarkers() {
    mainMarkers = Set();
    mainMarkers.add(Marker(
      //add start location marker
      markerId: MarkerId('1'),
      position: LatLng(31.931994, 35.971159), //position of marker

      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet), //Icon for Marker
    ));

    mainMarkers.add(Marker(
      //add start location marker
      markerId: MarkerId('2'),
      position: LatLng(31.926727, 35.969202), //position of marker

      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet), //Icon for Marker
    ));
  }

  updateMarker() {
    setState(() {
      mainMarkers = Set();
      mainMarkers.add(Marker(
        //add start location marker
        markerId: MarkerId('1'),
        position: LatLng(31.926727, 35.969202), //position of marker

        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), //Icon for Marker
      ));
    });
  }

  addPolyLine() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAlXsI54m4ne6uIYzoVDAv-PNX8dhJAUks",
      PointLatLng(31.926727, 35.969202),
      PointLatLng(31.931994, 35.971159),
      travelMode: TravelMode.driving,
    );
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 2,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getDistance(
            fromLat: "31.931994",
            fromLng: "35.971159",
            toLat: "31.926727",
            toLng: "35.969202",
          ).then((value) {
            print(value);
          });
        },
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Column(
        children: [
          Text("This is map"),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GoogleMap(
              onCameraMove: (value) {
                print(value);
              },
              onCameraIdle: () {
                print("Stoped");
              },
              polylines: Set<Polyline>.of(polylines.values),
              markers: mainMarkers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future getDistance({fromLat, fromLng, toLat, toLng}) async {
    final dio = Dio();

    var response;
    try {
      response = await dio.get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$fromLat,$fromLng&origins=$toLat,$toLng&key=AIzaSyAlXsI54m4ne6uIYzoVDAv-PNX8dhJAUks');
    } catch (e) {
      print("exception handld is :" + e.toString());
    }

    var distance = double.parse(response.data["rows"][0]["elements"][0]
            ["distance"]["text"]
        .toString()
        .split(' ')
        .first);

    var time = response.data["rows"][0]["elements"][0]["duration"]["text"]
        .toString()
        .split(' ')
        .first;
    Map data = {'data': response.data, "distance": distance, "time": time};

    return data;
  }
}
