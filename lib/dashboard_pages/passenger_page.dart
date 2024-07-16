import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_home.dart';

class PassengersPage extends StatelessWidget {
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
                    'Passengers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: usersCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error fetching passengers');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final passengers = snapshot.data?.docs ?? [];
                      final passengerCount = passengers.length;

                      return Text(
                        '$passengerCount Passengers Registered',
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
                      stream: usersCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error fetching passengers');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final passengers = snapshot.data?.docs ?? [];

                        return ListView.builder(
                          itemCount: passengers.length,
                          itemBuilder: (context, index) {
                            final passenger =
                            passengers[index].data() as Map<String, dynamic>;
                            return PassengerCard(passenger: passenger);
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

class PassengerCard extends StatelessWidget {
  final Map<String, dynamic>? passenger;

  const PassengerCard({required this.passenger});

  @override
  Widget build(BuildContext context) {
    if (passenger == null) {
      return Container();
    }

    final String image = passenger!['image'] ?? '';
    final String displayName = passenger!['displayName'] ?? '';
    final String phoneNumber = passenger!['phoneNumber'] ?? '';
    final String cnic = passenger!['cnic'] ?? '';
    final String address = passenger!['address'] ?? '';
    final String email = passenger!['email'] ?? '';
    final bool isDriver = passenger!['isDriver'] ?? false;

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
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: isDriver ? Colors.lightGreen : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                isDriver ? 'Driver' : 'Not a Driver',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deletePassenger();
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
    // return Card(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: ExpansionTile(
    //     title: Row(
    //       children: [
    //         CircleAvatar(
    //           backgroundImage: NetworkImage(image),
    //           radius: 24,
    //         ),
    //         SizedBox(width: 16),
    //         Text(
    //           displayName,
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         Spacer(),
    //         Container(
    //           decoration: BoxDecoration(
    //             color: isDriver ? Colors.lightGreen : Colors.red,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //           child: Text(
    //             isDriver ? 'Driver' : 'Not a Driver',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 12,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     children: [
    //       ListTile(
    //         title: Text('Phone Number $phoneNumber'),
    //       ),
    //       ListTile(
    //         title: Text('CNIC $cnic'),
    //       ),
    //       ListTile(
    //         title: Text('Address $address'),
    //       ),
    //       ListTile(
    //         title: Text('Email $email'),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           IconButton(
    //             icon: Icon(Icons.delete),
    //             onPressed: () {
    //               _deletePassenger();
    //             },
    //           ),
    //           SizedBox(width: 8),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  void _deletePassenger() {
    // Perform the deletion of the document from the 'users' collection
    if (passenger != null) {
      final String passengerId = passenger!['id'] ?? '';
      FirebaseFirestore.instance
          .collection('users')
          .doc(passengerId)
          .delete()
          .then((value) => print('Passenger deleted'))
          .catchError((error) => print('Failed to delete passenger: $error'));
    }
  }
}
