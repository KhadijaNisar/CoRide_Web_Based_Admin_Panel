import 'package:coride_admin/dashboard_pages/vehicle_requests_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_home.dart';


class VehicleRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Vehicle Requests',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<Iterable<String>>(
                    future: getAcceptedDrivers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No Vehicle Requests');
                      } else {
                        return Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('vehicle_data')
                                .where('userId', whereIn: snapshot.data)
                                .where('vehicleStatus', isEqualTo: 'requested')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Text('No Vehicle Requests');
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var vehicleData = snapshot.data!.docs[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VehiclesDetailScreen(vehicleData: vehicleData,documentId: vehicleData.id),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        margin: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(vehicleData['vehicleImageUrl']),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                vehicleData['brand'],
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Iterable<String>> getAcceptedDrivers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('isDriver', isEqualTo: true)
        .where('driverStatus', isEqualTo: 'accepted')
        .get();
    return snapshot.docs.map((doc) => doc.id);
  }
}