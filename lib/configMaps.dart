import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver_ambulance/Models/allUsers.dart';
import 'package:geolocator/geolocator.dart';

import 'Models/drivers.dart';

String mapKey = "AIzaSyCu138pjIJOTPoOS_HO_oY_uvc8vGlGYkE";

User? firebaseUser;
Users? userCurrentInfo;
final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentfirebaseUser;
StreamSubscription <Position>? HomeTapPageStreamSubscription;
StreamSubscription<Position>? rideStreamSubscription;

final assetsAudioPlayer = AssetsAudioPlayer();

late Position currentPosition;

Drivers? driversInformation;

String title ="";

double starCounter =0.0;