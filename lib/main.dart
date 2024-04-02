import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';

import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo[800],
      ),
      home: mainpage()));
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  askpermissions() async {
    if (!await Nearby().checkLocationPermission()) {
      await Nearby().askLocationPermission();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Location permission enabled")));
    }
    if (!await Nearby().checkBluetoothPermission()) {
      Nearby().askBluetoothPermission();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Bluetooth enabled")));
    }
    if (!await Nearby().checkLocationEnabled()) {
      Nearby().enableLocationServices();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Location enabled")));
    }
  }

  @override
  initState() {
    askpermissions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              askpermissions();
              if (snapshot.hasData) {
                return homepage();
              } else {
                return login();
              }
            }),
      ),
    );
  }
}
