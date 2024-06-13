import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../view/view_layer.dart';
import '../data_layer.dart';


// open the map to select the any location
class NearestMap extends StatefulWidget {
  const NearestMap({Key? key}) : super(key: key);

  @override
  _NearestMapState createState() => _NearestMapState();
}

class _NearestMapState extends State<NearestMap> {
  late GoogleMapController mapController;
  late CameraPosition cam_pos = CameraPosition(
      target: LatLng(sharedUser.latitude!, sharedUser.longitude!), zoom: 13);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};
  MapType currentMapType = MapType.hybrid;
  bool markerAdded = false;

  @override
  Widget build(BuildContext context) {
    PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        leading: IconButton(
          onPressed: () {
            //locationRoute
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.grey,
            size: 25,
          ),
        ),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (MapType result) {
              setState(() {
                currentMapType = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
              const PopupMenuItem<MapType>(
                value: MapType.normal,
                child: Text('Normal'),
              ),
              const PopupMenuItem<MapType>(
                value: MapType.satellite,
                child: Text('Satellite'),
              ),
              const PopupMenuItem<MapType>(
                value: MapType.terrain,
                child: Text('Terrain'),
              ),
              const PopupMenuItem<MapType>(
                value: MapType.hybrid,
                child: Text('Hybrid'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: currentMapType,
              initialCameraPosition: cam_pos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
              },
              onTap: _handleTap,
              markers: markers,
            ),
          ),
          if (markerAdded) // Show me the button if the marker is added
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(
                    LayoutManager.widthNHeight0(context, 1) * 0.15),
                child: defaultButton(
                  text: '       Done       ',
                  width: LayoutManager.widthNHeight0(context, 1) * 0.45,
                  borderRadius: 18,
                  background: ThemeManager.primary,
                  textColor: ThemeManager.second,
                  onPressed: () {
                    placeProvider.updatePosition(
                        selectedNearestLat, selectedNearestLog);
                    Navigator.of(context).pop();
                  },
                  borderWidth: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      markerAdded = true;
    });

    selectedNearestLat = tappedPoint.latitude;
    selectedNearestLog = tappedPoint.longitude;
  }

  @override
  void initState() {
    super.initState();
  }
}
