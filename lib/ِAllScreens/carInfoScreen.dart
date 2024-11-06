import 'package:driver_ambulance/%D9%90AllScreens/mainScreen.dart';
import 'package:driver_ambulance/%D9%90AllScreens/registerationScreen.dart';
import 'package:driver_ambulance/configMaps.dart';
import 'package:driver_ambulance/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CarInfoScreen extends StatelessWidget
{
  static const String idScreen = "carinfo";
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/ambulance_logo_final.png"),
              ),

              const SizedBox(height: 15,),
              const Text(
                "Enter Your Ambulance Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32,),

              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Ambulance Model",
                  hintText: "Enter the model of your Ambulance",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),



                ),

              ),

              const SizedBox(height: 40,),

              TextField(
                controller: carNumberTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Ambulance Number",
                  hintText: "Enter the number of your Ambulance",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),



                ),

              ),
              const SizedBox(height: 40,),

              TextField(
                controller: carColorTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Ambulance Color",
                  hintText: "Enter the color of your Ambulance",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),


                ),

              )


              ,const SizedBox(height: 40,),

              ElevatedButton(
                onPressed: ()
                {
                  //Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen() ));
                  if (carModelTextEditingController.text.isEmpty)
                  {
                    displayToastMessage("please write Car Model.", context);
                  }
                  else if (carNumberTextEditingController.text.isEmpty)
                  {
                    displayToastMessage("please write Car Number.", context);
                  }
                  else if (carColorTextEditingController.text.isEmpty)
                  {
                    displayToastMessage("please write Car Color.", context);
                  }
                  else
                  {
                    saveDriverCarInfo(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 50),
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(15.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50),),
                  ),

                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  void saveDriverCarInfo(context) {

    String userId = currentfirebaseUser!.uid;

    Map carInfoMap =
    {
      "car_color":  carColorTextEditingController.text,
      "car_number": carNumberTextEditingController.text,
      "car_model": carModelTextEditingController.text,
    };
    driversRef.child(userId).child("car_details").set(carInfoMap);
    currentfirebaseUser = firebaseUser;
    //Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));



  }

}
