import 'package:driver_ambulance/Models/history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:driver_ambulance/Models/address.dart';

class AppData extends ChangeNotifier
{
   Address? pickUpLocation, dropOffLocation;
   String earnings = '0';
   int countTrips = 0;
   List<String> tripHistoryKeys =[];
   List<HistoryModel> tripHistoryDataList =[];

    void updatePickUpLocationAddress(Address pickUpAddress)
     {
    pickUpLocation = pickUpAddress;
     notifyListeners();
    }

   void updateDropOffLocationAddress(Address dropOffAddress)
   {
    dropOffLocation = dropOffAddress;
     notifyListeners();
   }

   void updateEarnings(String updatedEarnings)
   {
     earnings = updatedEarnings;
     notifyListeners();
   }

   void updateTripsCounter(int tripCounter)
   {
     countTrips = tripCounter;
     notifyListeners();
   }

   void updateTripKeys(List<String> newKeys)
   {
     tripHistoryKeys = newKeys;
     notifyListeners();
   }

   void updateTripHistoryData(HistoryModel eachHistory)
   {
     tripHistoryDataList.add(eachHistory);
     notifyListeners();
   }

}