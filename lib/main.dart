import 'package:driver_ambulance/configMaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:driver_ambulance/%D9%90AllScreens/loginScreen.dart';
import 'package:driver_ambulance/%D9%90AllScreens/mainScreen.dart';
import 'package:driver_ambulance/%D9%90AllScreens/registerationScreen.dart';
import 'package:driver_ambulance/%D9%90AllScreens/splash_screen.dart';
import 'package:driver_ambulance/DataHandler/appData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  currentfirebaseUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
    child: ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'اسعافك',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MySplashScreen(),
        debugShowCheckedModeBanner: false,           //to remove the red debug banner
      ),
    ),
  ),);
}

 DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
 DatabaseReference driversRef = FirebaseDatabase.instance.reference().child("drivers");
 DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("drivers").child(currentfirebaseUser!.uid).child("newRide");
 DatabaseReference newRequestsRef = FirebaseDatabase.instance.reference().child("Ride Requests");
class MyApp extends StatefulWidget
{
  final Widget? child;          // the '?' here to check if it's null

  MyApp({this.child});

  //a method to restart the app
  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();      //the '!' here means to check that my app state is not null
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();
  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}


