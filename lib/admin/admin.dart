import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:nearbybluetooth/admin/userdetails.dart';
import 'package:nearbybluetooth/admin/userentries.dart';
import 'package:nearbybluetooth/datemodifier.dart';
import 'package:nearbybluetooth/notificationservice.dart';

class adminpage extends StatefulWidget {
  const adminpage({Key? key}) : super(key: key);

  @override
  State<adminpage> createState() => _adminpageState();
}

class _adminpageState extends State<adminpage> {
  List<Map<String, String>> endpointmap = [];
  datemodifier d = datemodifier();
  String starttime = "";
  String startdate = "";

  @override
  Widget build(BuildContext context) {
    final mykey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
          key: mykey,
          drawer: Drawer(
            backgroundColor: Colors.indigo[800],
            child: Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => entries()));
                      },
                      child: Text(
                        "Notification",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.indigo[200],
                    height: 10.0,
                  ),
                  ListTile(
                    title: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => details()));
                      },
                      child: Text(
                        "User Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.indigo[200],
                    height: 10.0,
                  ),
                  ListTile(
                    title: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.indigo[200],
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        if (mykey.currentState!.isDrawerOpen) {
                          mykey.currentState!.closeDrawer();
                        } else {
                          mykey.currentState!.openDrawer();
                        }
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.indigo[800],
                      )),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dashboard",
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${d.getdate()}",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.indigo[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        height: 220,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.bluetooth_connected,
                                color: Colors.indigo[800],
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 100.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  starttime = d.gettime();
                                  startdate = d.getdate();
                                  discover();
                                  advertise("admin");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Searching")));
                                },
                                child: Text(
                                  "Find",
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.indigo[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        height: 220,
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.bluetooth_connected,
                                color: Colors.white,
                              ),
                              radius: 30,
                              backgroundColor: Colors.indigo[800],
                            ),
                            SizedBox(
                              width: 100.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  int a = d.gethoursfromtime(
                                      starttime, d.gettime());

                                  FirebaseFirestore.instance
                                      .collection("workingdays")
                                      .doc(startdate + starttime)
                                      .set({
                                    'date': startdate,
                                    'starttime': starttime,
                                    'endtime': d.gettime(),
                                    'total': a.toString()
                                  });

                                  Nearby().stopDiscovery();
                                  Nearby().stopAdvertising();

                                  setState(() {
                                    endpointmap.clear();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "All the records saved successfully")));
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
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
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
                    "Connections",
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: endpointmap.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.indigo[50],
                          child: ListTile(
                            title: Text("${endpointmap[index]['name']}"),
                            subtitle:
                                Text("In Time : ${endpointmap[index]['in']}"),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> discover() async {
    setState(() {
      endpointmap.clear();
    });

    await Nearby().startDiscovery("admin", Strategy.P2P_STAR,
        onEndpointFound: onEndpointFound, onEndpointLost: onEndpointLost);
  }

  void onEndpointFound(String endpointId, String uid, String serviceId) {
    print(endpointId);

    var userDetail;
    FirebaseFirestore.instance
        .collection('userinfo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot doc) {
      userDetail = doc;
      var name =
          userDetail.exists ? userDetail.data()['name'] : "Doc does not exist";
      setState(() {
        endpointmap.add(
            {'eid': endpointId, 'uid': uid, 'name': name, "in": d.gettime()});
      });
      NotificationService().showNotification(0, "A User Entered", name, 5);
    });
  }

  void onEndpointLost(String? endpointId) {
    int index = 0, i = 0;
    endpointmap.forEach((element) {
      if (element.containsKey(endpointId)) {
        index = i;
      }
      i += 1;
    });

    FirebaseFirestore.instance
        .collection("userentry")
        .doc(endpointmap[index]['eid'])
        .set({
      'uid': endpointmap[index]['uid'],
      'date': d.getdate(),
      'in': endpointmap[index]['in'],
      'out': d.gettime()
    });
    NotificationService()
        .showNotification(0, "A User Left", endpointmap[index]['name']!, 100);
    setState(() {
      endpointmap.removeAt(index);
    });

    print("connection end..!");
  }

  Future<void> advertise(name) async {
    await Nearby().startAdvertising(name, Strategy.P2P_STAR,
        onConnectionInitiated: (String id, ConnectionInfo info) {},
        onConnectionResult: (id, status) {},
        onDisconnected: (id) {});
  }
}
