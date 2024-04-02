import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

class authenticate extends StatefulWidget {
  const authenticate({Key? key}) : super(key: key);

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    hintText: "Email"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.black,
                    ),
                    hintText: "Name"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Password"),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                  child: Text(
                    "already have account? Login",
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: pass.text)
          .then((value) {
        FirebaseFirestore.instance
            .collection("userinfo")
            .doc(value.user?.uid)
            .set({'name': name.text, 'email': email.text});
      });
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      });
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE')
          print("Email already in use");
      }
    }
  }
}
