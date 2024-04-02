import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  List<Map<String, String>> lis = [];

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
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("userinfo")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        child: Text(
                                          snapshot.data?.docs[index]['name']!,
                                          style: TextStyle(
                                            color: Colors.indigo[800],
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Align(
                                        child: Text(
                                          snapshot.data?.docs[index]['email']!,
                                          style: TextStyle(
                                            color: Colors.indigo[800],
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("something went wrong");
                      }
                      return Center(
                          child: Container(
                              height: 100.0,
                              child: CircularProgressIndicator()));
                    })),
          ],
        ),
      ),
    );
  }
}
