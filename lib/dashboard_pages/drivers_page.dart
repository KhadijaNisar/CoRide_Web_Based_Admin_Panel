import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../admin_home.dart';

class DriversPage extends StatelessWidget {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drivers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: usersCollection
                        .where('driverStatus', isEqualTo: 'accepted')
                        .where('isDriver', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error fetching drivers');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final drivers = snapshot.data?.docs ?? [];
                      final driverCount = drivers.length;

                      return Text(
                        '$driverCount Drivers Registered',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: usersCollection
                          .where('driverStatus', isEqualTo: 'accepted')
                          .where('isDriver', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error fetching drivers');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final drivers = snapshot.data?.docs ?? [];

                        return ListView.builder(
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            final driver =
                            drivers[index].data() as Map<String, dynamic>;
                            return DriverCard(driver: driver);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  void _deleteDriver(BuildContext context, String documentId) {
    // Update the Firestore document
    FirebaseFirestore.instance.collection('users').doc(documentId).update({
      'isDriver': false,
      'driverStatus': FieldValue.delete(),
    }).then((_) {
      // Show a success message or perform any additional actions
      print('Driver deleted successfully');
    }).catchError((error) {
      // Show an error message or handle the error
      print('Failed to delete driver: $error');
    });
  }
  final Map<String, dynamic>? driver;

  const DriverCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    if (driver == null) {
      return Container();
    }
    final String image = driver!['image'] ?? '';
    final String backImageUrl = driver!['backImageUrl'] ?? '';
    final String frontImageUrl = driver!['frontImageUrl'] ?? '';
    final String displayName = driver!['displayName'] ?? '';
    final String phoneNumber = driver!['phoneNumber'] ?? '';
    final String cnic = driver!['cnic'] ?? '';
    final String address = driver!['address'] ?? '';
    final String email = driver!['email'] ?? '';
    final String documentId = driver!['uid'] ?? '';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 24,
            ),
            SizedBox(width: 16),
            Text(
              displayName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Lighter color for the name
              ),
            ),
          ],
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      subtitle: Text(
                        phoneNumber,
                        style: TextStyle(
                          color: Colors.black, // Black color for the value
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      subtitle: Text(
                        address,
                        style: TextStyle(
                          color: Colors.black, // Black color for the value
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'CNIC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      subtitle: Text(
                        cnic,
                        style: TextStyle(
                          color: Colors.black, // Black color for the value
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(
                          color: Colors.black, // Black color for the value
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CNIC Front Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            frontImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(width: 25),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CNIC Back Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Lighter color for the name
                        ),
                      ),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            backImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // _deletePassenger();
                  _deleteDriver(context, documentId);
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
