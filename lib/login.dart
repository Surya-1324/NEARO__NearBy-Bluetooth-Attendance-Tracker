import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearbybluetooth/admin/admin.dart';
import 'package:nearbybluetooth/main.dart';
import 'package:nearbybluetooth/signup.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();

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
                "Login",
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                cursorColor: Colors.indigo[800],
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                cursorColor: Colors.indigo[800],
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
                    loginto();
                  },
                  child: Text(
                    "Login",
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
                    setState(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => authenticate()));
                    });
                  },
                  child: Text(
                    "Don't have account?  Sign Up",
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginto() async {
    if (email.text == "admin@gmail.com" || pass.text == "admin123") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => adminpage()));
    } else {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => mainpage()));
    }
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }
}
