

import 'package:flutter_geofire/flutter_geofire.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:driver_ambulance/Assistants/requestAssistant.dart';
import 'package:driver_ambulance/DataHandler/appData.dart';

import 'package:driver_ambulance/Models/directionDetails.dart';
import 'package:driver_ambulance/configMaps.dart';
import 'package:driver_ambulance/Models/history_model.dart';
import '../main.dart';

class AssistantMethods
{
  //static Future<String> searchCoordinateAddress(Position position, context) async
  //{
    //String placeAddress = "";
   // String st1,st2,st3,st4;
    //var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey");
    //String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    // url as String
    //var response = await RequestAssistant.getRequest(url);

   // if(response != 'failed')
   // {
      //placeAddress = response["results"][0]["formatted_address"];
      //st1 = response["results"][0]["address_components"][0]["long_name"];
     // st2 = response["results"][0]["address_components"][2]["long_name"];
      //st3 = response["results"][0]["address_components"][4]["long_name"];
      //st4 = response["results"][0]["address_components"][5]["long_name"];
      //placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      //Address userPickUpAddress = new Address();
      //userPickUpAddress.longitude = position.longitude;
     // userPickUpAddress.latitude = position.latitude;
      //userPickUpAddress.placeName = placeAddress;

     // Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);


    //}


    //return placeAddress;


  static Future<DirectionDetails?> obtainPlaceDirectionsDetails(LatLng intialPosition, LatLng finalPosition) async
  {
    var directionUrl = Uri.parse("https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${intialPosition.latitude},${intialPosition.longitude}&key=$mapKey");

    var response = await RequestAssistant.getRequest(directionUrl);

    if(response == "failed")
    {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.encodedPoints = response["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText = response["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = response["routes"][0]["legs"][0]["distance"]["value"];
    directionDetails.durationText = response["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = response["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;

  }

  static int calculateFares(DirectionDetails directionDetails) {
    //in terms USD
    double timeTraveledFared = (directionDetails.durationValue!/ 60) * 0.20;
    double distanceTraveledFare = (directionDetails.distanceValue!/ 1000) *
        0.20;
    double totalFareAmount = (timeTraveledFared + distanceTraveledFare) *
        9.8; // convert to mad

    //local currency
    //1$ = 160rs
    //double totallocalamount = totalFareAmount *160;
    return totalFareAmount.truncate();
  }

  //static void getCurrentOnlineUserInfo() async
  //{
   // firebaseUser = (await FirebaseAuth.instance.currentUser)!;
   // String userId = firebaseUser!.uid;
    //DatabaseReference reference = FirebaseDatabase.instance.ref().child("users").child(userId);

    //reference.once().then((event)
    //{
    //  final dataSnapShot = event.snapshot;
     // if(dataSnapShot.value != null)
     // {
       // userCurrentInfo = Users.fromSnapshot(dataSnapShot);
      //}

    //});

  //}
  static void disableHomeTabLiveLocationUpdate()
  {
    HomeTapPageStreamSubscription?.pause();
    Geofire.removeLocation(currentfirebaseUser!.uid);
  }

  static void enableHomeTabLiveLocationUpdate()
  {
    HomeTapPageStreamSubscription?.resume();
    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition.latitude, currentPosition.longitude);
  }

  static void retrieveHistoryInfo(context)
  {

    //retrieve and display Earnings
    driversRef.child(currentfirebaseUser!.uid).child("earnings").once().then((event )
    {
      final dataSnapshot = event.snapshot;
      if(dataSnapshot.value != null)
      {
        String earnings = dataSnapshot.value.toString();
        Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
      }
    });

    driversRef.child(currentfirebaseUser!.uid).child("history").once().then(( event)
    {
      final dataSnapshot = event.snapshot;
      if(dataSnapshot.value != null)
      {
        //update total number of trip counts to provider
        Map<dynamic, dynamic> keys = dataSnapshot.value as Map<String, dynamic>;
        int tripCounter = keys.length;
        Provider.of<AppData>(context, listen: false).updateTripsCounter(tripCounter);

        //update trip keys to provider
        List<String> tripHistoryKeys = [];
        keys.forEach((key,value)
        {
          tripHistoryKeys.add(key);
        });
        Provider.of<AppData>(context, listen: false).updateTripKeys(tripHistoryKeys);
        obtainTripRequestHistoryData(context);
      }
    });
  }

  static void obtainTripRequestHistoryData(context)
  {
    var keys =   Provider.of<AppData>(context, listen: false).tripHistoryKeys;
    for(String key in keys)
    {
      newRequestsRef.child(key).once().then((event)
      {
        final datasnapshot = event.snapshot;
        if(datasnapshot.value!=null)
        {
          var history = HistoryModel.fromSnapshot(datasnapshot);
          Provider.of<AppData>(context, listen: false).updateTripHistoryData(history);
        }
      });
    }
  }

  static String formatTripDates(String date)
  {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }



}