import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:geocoder/geocoder.dart';


class AddressMap extends StatefulWidget {
  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  GoogleMapController _controller;
  String currentAddress,updatedAddress,_address;
  Uint8List customIcon;


  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("res/pin.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home1"),
          position: latlng,
          draggable: false,
          icon: BitmapDescriptor.fromBytes(imageData));
    });
  }

  void getCurrentLocation() async {


      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 0,
              target: LatLng(location.latitude, location.longitude),
              tilt: 0,
              zoom: 24.00)));
          updateMarkerAndCircle(location, imageData);

      setState(() {
        _getAddress(location.latitude, location.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
            currentAddress = _address;
          });
        });
      });
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('fff'),
      ),
      body: Column(
        children: [
          Flexible(
            child: GoogleMap(
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: initialLocation,
                markers: Set.of((marker != null) ? [marker] : []),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  getCurrentLocation();
                },
                onTap: _setMarker),
          ),
          Card(
            elevation: 40,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set delivery location',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                HeightBox(10),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text('$_address',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                                Divider(
                                    endIndent: 0,
                                    thickness: 1,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "EDIT",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
  _setMarker(LatLng tappedLoc) {
    setState(() {
      marker = Marker(
          markerId: MarkerId("home1"),
          position: tappedLoc,
          draggable: false,
          icon: BitmapDescriptor.fromBytes(customIcon));
    });
    LatLng pinCoordinates = tappedLoc;
    setState(() {
      _getAddress(pinCoordinates.latitude, pinCoordinates.longitude)
          .then((value) {
        setState(() {
          _address = "${value.first.addressLine}";
          updatedAddress = _address;
        });
      });
    });
  }
}