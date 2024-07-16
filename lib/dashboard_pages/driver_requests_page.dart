import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_home.dart';
import 'drivers_requests_details.dart';

class DriverRequestsPage extends StatelessWidget {
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
                    'Driver Requests',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('driverStatus', isEqualTo: 'requested')
                        .where('isDriver', isEqualTo: true)
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('No Driver Requests');
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var userData = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DriverDetailsScreen(userData: userData),
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
                                          backgroundImage: NetworkImage(userData['image']),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          userData['displayName'],
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
}

// class DriverDetailsScreen extends StatelessWidget {
//   final DocumentSnapshot userData;
//
//   const DriverDetailsScreen({Key? key, required this.userData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Row(
//         children: [
//           SideMenu(),
//           Expanded(
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       userData['displayName'],
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Phone Number: ${userData['phoneNumber']}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Email: ${userData['email']}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Address: ${userData['address']}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 20),
//                     Image.network(userData['image']),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Accept action
//                             FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(userData.id)
//                                 .update({'driverStatus': 'accepted'});
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green,
//                           ),
//                           child: Text('Accept'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Reject action
//                             FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(userData.id)
//                                 .update({'isDriver': false});
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.red,
//                           ),
//                           child: Text('Reject'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// import '../admin_home.dart';
//
// class DriverRequestsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           SideMenu(),
//           Expanded(
//             child: Center(
//               child: Text('Driver Requests Page Content'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }