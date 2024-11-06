import 'package:driver_ambulance/%D9%90AllScreens/carInfoScreen.dart';
import 'package:driver_ambulance/configMaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:driver_ambulance/%D9%90AllScreens/loginScreen.dart';
import 'package:driver_ambulance/%D9%90AllScreens/mainScreen.dart';
import 'package:driver_ambulance/AllWidgets/progressDialog.dart';
import 'package:driver_ambulance/main.dart';

class registerationScreen extends StatefulWidget {
  static const String idScreen = "register";


  @override
  State<registerationScreen> createState() => _registerationScreenState();
}



class _registerationScreenState extends State<registerationScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(nameTextEditingController.text.length <3)
      {
        Fluttertoast.showToast(msg: "Name must be at least 3 characters");
      }
    else if(!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email address is not valid");
      }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone number is required");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    }
    else
    {
      registerNewdriver(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/ambulance_logo_final.png"),
              ),

              const Text(
                "Register as a Driver",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  //color: Color(0xff851313),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),

              const SizedBox(height: 20,),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300
                  ),



                ),

              ),

              const SizedBox(height: 8,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300
                  ),



                ),

              ),

              const SizedBox(height: 8,),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter your phone",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300
                  ),



                ),

              ),

              const SizedBox(height: 8,),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),



                ),

              ),

              const SizedBox(height: 21,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
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
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 1,),

              TextButton(
                child: const Text(
                  "Already Have an Account ? | Login Here",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Raleway',
                  ),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen() ));
                },
              ),


            ],
          ),
        ),

      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewdriver(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, Please wait...");
        }
    );

    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errormsg){
      Navigator.pop(context);
      displayToastMessage("Error: " + errormsg.toString(), context);
    })).user;
    if(firebaseUser != null)    //user created successfully
      {
        // save user to database
        Map userDataMap = {
          "name":nameTextEditingController.text.trim(),
          "email":emailTextEditingController.text.trim(),
          "phone":phoneTextEditingController.text.trim(),
        };

        driversRef.child(firebaseUser.uid).set(userDataMap);
        currentfirebaseUser = firebaseUser;

        displayToastMessage("Congratulation, your account has been created successfully", context);
       // Navigator.pushNamed(context, CarInfoScreen.idScreen);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
      }
    else
      {
        Navigator.pop(context);
        //error occured ;display error msg
        displayToastMessage("New user account has not been created.", context);
      }

  }
}

displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}