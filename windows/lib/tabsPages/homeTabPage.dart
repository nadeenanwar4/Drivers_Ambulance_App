import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:driver_ambulance/%D9%90AllScreens/registerationScreen.dart';
import 'package:driver_ambulance/configMaps.dart';
import 'package:driver_ambulance/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Assistants/assistantMethods.dart';
import '../Models/drivers.dart';
import '../Notifications/pushNotificationService.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  HomeTabPageState createState() => HomeTabPageState();
}

class HomeTabPageState extends State<HomeTabPage> {
  final Completer<GoogleMapController> _controllerGoogleMap =
  Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  Position? currentPosition;
  final geoLocator = GeolocatorPlatform.instance;


  String driverStatusText = "Offline Now - Go Online";
  Color driverStatusColor = Colors.black;
  bool isDriverAvailable = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    geoLocator.requestPermission();
    getCurrentDriverInfo();
  }

  @override
  void dispose() {
    HomeTapPageStreamSubscription?.cancel();
    super.dispose();
  }

  getRatings()
  {
    driversRef.child(currentfirebaseUser!.uid).child("ratings").once().then((event)
    {
      final dataSnapshot = event.snapshot;
      if(dataSnapshot.value != null)
      {
        double ratings = double.parse(dataSnapshot.value.toString());
        setState(() {
          starCounter = ratings;
        });
        if(starCounter <= 1.5)
        {
          setState(() {
            title = "Very Bad";
          });
          return;
        }
        if(starCounter <= 2.5)
        {
          setState(() {
            title = " Bad";
          });
          return;
        }
        if(starCounter <= 3.5)
        {
          setState(() {
            title = "Good";
          });
          return;
        }
        if(starCounter <= 4.5)
        {
          setState(() {
            title = "Very Good";
          });
          return;
        }
        if(starCounter <= 5.5)
        {
          setState(() {
            title = "Exellent";
          });
          return;
        }
      }
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;


    final latLngPosition = LatLng(position.latitude, position.longitude);
    final cameraPosition =
    CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        cameraPosition)); // Update camera position

    // String address = await AssistantMethods.searchCoordinateAddress(position,context);
    // print("This is your Address :: " + address);
  }

  void getCurrentDriverInfo() async
  {
    currentfirebaseUser = FirebaseAuth.instance.currentUser;

    driversRef.child(currentfirebaseUser!.uid).once().then((event){
      final dataSnapShot = event.snapshot;
      if(dataSnapShot.value !=null)
      {
        driversInformation = Drivers.fromSnapshot(dataSnapShot);
      }
    });
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();

    AssistantMethods.retrieveHistoryInfo(context);
    getRatings();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          // zoomGesturesEnabled: true,
          // zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller)
          async {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            locatePosition();

            //LocationPermission permission;
            //permission = await Geolocator.requestPermission();

          },

        ),
        // online or offline
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black54,
        ),
        Positioned(
            top: 60.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: ()
                  {
                    if (isDriverAvailable != true) {
                      makeDriverOnlineNow();
                      getLocationLiveUpdates();

                      setState(() {
                        driverStatusColor = Colors.green;
                        driverStatusText = "Online Now";
                        isDriverAvailable = true;
                      });
                      displayToastMessage("You are Online Now.", context);

                    }
                    else {
                      makeDriverOfflineNow();
                      setState(() {
                        driverStatusColor = Colors.black;
                        driverStatusText = "Offline Now - Go Online";
                        isDriverAvailable = false;
                      });


                      displayToastMessage("You are Offline Now.", context);

                    }


                  }

                  //},
                  ,label: Text(driverStatusText),
                  icon: const Icon( Icons.phone_android, color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ],
            ))

      ],
    );
  }
  void makeDriverOnlineNow() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    Geofire.initialize("availableDrivers");
    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition!.latitude, currentPosition!.longitude);

    rideRequestRef!.set("searching");
    rideRequestRef.onValue.listen((event) {

    });
  }

  void getLocationLiveUpdates(){
    HomeTapPageStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          currentPosition = position;
          if (isDriverAvailable == true) {
            Geofire.setLocation(
                currentfirebaseUser!.uid, position.latitude, position.longitude);
          }
          LatLng latLng = LatLng(position.latitude, position.longitude);
          newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
        });
  }

  void makeDriverOfflineNow()
  {
    Geofire.removeLocation(currentfirebaseUser!.uid);
    rideRequestRef.onDisconnect();
    rideRequestRef.remove();
    rideRequestRef=null!;



  }


}





