import 'package:flutter/material.dart';

class entries extends StatefulWidget {
  const entries({Key? key}) : super(key: key);

  @override
  State<entries> createState() => _entriesState();
}

getname(uid) {}

class _entriesState extends State<entries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "User Details",
              style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
