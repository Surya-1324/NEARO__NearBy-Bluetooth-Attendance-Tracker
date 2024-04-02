import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:nearbybluetooth/datemodifier.dart';
import 'package:nearbybluetooth/profile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Map<String, String>> endpointmap = [];
  String eid = "";
  bool adminstatus = false;
  late String? name;
  datemodifier d = datemodifier();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DashBoard",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        var uname;

                        var userDetail;

                        FirebaseFirestore.instance
                            .collection('userinfo')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get()
                            .then((DocumentSnapshot doc) {
                          userDetail = doc;
                          uname = userDetail.exists
                              ? userDetail.data()['name']
                              : "Doc does not exist";

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile(
                                      uid: FirebaseAuth
                                          .instance.currentUser?.uid,
                                      email: FirebaseAuth
                                          .instance.currentUser?.email,
                                      name: uname)));
                        });
                      },
                      icon: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.indigo[800],
                      )),
                )
              ]),
              Align(
                child: Text("${d.getdate()}"),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 220.0,
                      width: 150.0,
                      decoration: ShapeDecoration(
                          color: Colors.indigo[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.bluetooth_connected_sharp,
                              color: Colors.indigo[800],
                            ),
                            backgroundColor: Colors.white,
                            radius: 30.0,
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              advertise(FirebaseAuth.instance.currentUser?.uid);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Searching...",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.indigo[800],
                                duration: Duration(seconds: 8),
                              ));
                            },
                            child: Text(
                              "Advertise",
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 220.0,
                      width: 150.0,
                      decoration: ShapeDecoration(
                          color: Colors.indigo[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.bluetooth_disabled,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.indigo[800],
                            radius: 30.0,
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Nearby().stopAdvertising();
                              Nearby().stopDiscovery();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Saving your Entry...",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.indigo[800],
                                duration: Duration(seconds: 10),
                              ));
                            },
                            child: Text(
                              "Stop",
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.indigo[800],
                height: 20.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Active Status",
                  style: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  color: Colors.indigo[50],
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Admin",
                          style: TextStyle(
                            color: Colors.indigo[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (adminstatus) ...[
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                        ] else ...[
                          Icon(
                            Icons.wrong_location,
                            color: Colors.red,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                  )),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.indigo[200],
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                  color: Colors.indigo[800],
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            "My Attendance",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20.0,
              ),
              Card(
                  color: Colors.indigo[800],
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            "Your Entry Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> advertise(name) async {
    await Nearby().startDiscovery("admin", Strategy.P2P_STAR,
        onEndpointFound: onEndpointFound, onEndpointLost: onEndpointLost);
    await Nearby().startAdvertising(name, Strategy.P2P_STAR,
        onConnectionInitiated: onConnectionInitiated,
        onConnectionResult: (id, status) {
      print(id);
      print('$endpointmap["id"]');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("{$endpointmap['id']} $status")));
    }, onDisconnected: (id) {
      setState(() {
        endpointmap.remove(id);
      });
    });
  }

  onConnectionInitiated(String id, ConnectionInfo info) {
    setState(() {
      endpointmap.add({id: info.endpointName});
      print({id: info});
    });
  }

  void onEndpointFound(String endpointId, String name, String serviceId) {
    if (name == "admin") {
      setState(() {
        adminstatus = true;
        eid = endpointId;
      });
    }
  }

  void onEndpointLost(String? endpointId) {
    if (endpointId == eid) {
      setState(() {
        adminstatus = false;
      });
    }
  }
}
