import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearbybluetooth/login.dart';

class profile extends StatefulWidget {
  var uid;
  var email, name;
  profile(
      {Key? key, required this.uid, required this.email, required this.name})
      : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? uid, name, email;

  void initState() {
    // TODO: implement initState
    uid = widget.uid;
    email = widget.email;
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.indigo[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.indigo[50],
              child: Icon(
                Icons.person,
                size: 150,
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Name\t\t:\t\t$name",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Email\t\t:\t\t$email",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 45.0,
                    width: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
