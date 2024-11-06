import 'package:firebase_database/firebase_database.dart';

class Drivers
{
  String? name;
  String? phone;
  String? email;
  String? id;
  String? car_color;
  String? car_model;
  String? car_number;

  Drivers(
  {
        this.name,
        this.phone,
        this.email,
        this.id,
        this.car_color,
        this.car_model,
        this.car_number
  });

  Drivers.fromSnapshot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key;
    phone = dataSnapshot.child("phone").value.toString();
    email = dataSnapshot.child("email").value.toString();
    name = dataSnapshot.child("name").value.toString();
    car_color = dataSnapshot.child("car_details").child("car_color").value.toString();
    car_model =  dataSnapshot.child("car_details").child("car_model").value.toString();
    car_number =  dataSnapshot.child("car_details").child("car_number").value.toString();
  }
}