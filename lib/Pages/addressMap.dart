import 'dart:async';
import 'dart:typed_data';
import 'package:address_app/services/getcurrentloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:geocoder/geocoder.dart';

class AddressMap extends StatefulWidget {
  @override
  _AddressMapState createState() => _AddressMapState();
  _AddressMapState a1 = new _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  List<Marker> marker1 = [];
  Marker marker;
  GoogleMapController _controller;
  String currentAddress, updatedAddress, _address;
  Functions functions = new Functions();
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'res/pin.png');
  }

  void updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      //marker1 = [];
      marker1.add(Marker(
          markerId: MarkerId(newLocalData.toString()),
          position: latlng,
          draggable: false,
          icon: pinLocationIcon));
    });
  }

  void getCurrentLocation() async {
    var location = await _locationTracker.getLocation();

    updateMarkerAndCircle(location);
    _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude, location.longitude),
        tilt: 0,
        zoom: 18.00)));
    //updateMarkerAndCircle(location, imageData);

    setState(() {
      functions.getAddress(location.latitude, location.longitude).then((value) {
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
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: initialLocation,
                markers: Set.from(marker1),
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
                Center(
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {},
                    child: Text('Save Address',
                        style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<Address>> getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  _setMarker(LatLng tappedLoc) {
    //marker1.clear();
    setState(() {
      marker1 = [];
      marker1.add(Marker(
          markerId: MarkerId(tappedLoc.toString()),
          position: tappedLoc,
          draggable: false,
          icon: pinLocationIcon));

      getAddress(tappedLoc.latitude, tappedLoc.longitude).then((value) {
        r = tappedLoc.latitude;
        t = tappedLoc.longitude;
        _address = "${value.first.addressLine}";
        updatedAddress = _address;
      });
    }); //LatLng pinCoordinates = tappedLoc
  }

  double r;
  double t;
}
