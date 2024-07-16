import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../admin_home.dart';
import 'dart:html' as html;

class DriverDetailsScreen extends StatelessWidget {
  final DocumentSnapshot userData;

  const DriverDetailsScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideMenu(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 150,
                    //   width: 150,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(75),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 2,
                    //         blurRadius: 5,
                    //         offset: Offset(0, 3),
                    //       ),
                    //     ],
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(75),
                    //     child: Image.network(
                    //       userData['image'],
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Text(
                      userData['displayName'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildImageField('User Profile Picture', userData['image']),
                    SizedBox(height: 20),
                        _buildField('Phone Number', userData['phoneNumber']),
                        _buildField('Email', userData['email']),
                    SizedBox(height: 20),
                    _buildField('CNIC', userData['cnic']),
                    _buildField('Address', userData['address']),
                    SizedBox(height: 20),
                    _buildImageField('Front CNIC Image', userData['frontImageUrl']),
                    SizedBox(height: 20),
                    _buildImageField('Back CNIC Image', userData['backImageUrl']),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Accept action
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userData.id)
                                .update({'driverStatus': 'accepted'});
                            // Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHomePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            'Accept',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Reject action
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userData.id)
                                .update({'isDriver': false});
                            // html.window.history.back();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHomePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            'Reject',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildImageField(String label, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 280,
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
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../admin_home.dart';
//
// class DriverDetailsScreen extends StatelessWidget {
//   final DocumentSnapshot userData;
//
//   const DriverDetailsScreen({Key? key, required this.userData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SideMenu(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(50),
//                             child: Image.network(
//                               userData['image'],
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           userData['displayName'],
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     _buildField('Phone Number', userData['phoneNumber']),
//                     _buildField('Email', userData['email']),
//                     SizedBox(height: 20),
//                     _buildField('CNIC', userData['cnic']),
//                     _buildField('Address', userData['address']),
//                     SizedBox(height: 20),
//                     _buildImageField('Front CNIC Image', userData['frontImageUrl']),
//                     SizedBox(height: 20),
//                     _buildImageField('Back CNIC Image', userData['backImageUrl']),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
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
//                             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                           ),
//                           child: Text(
//                             'Accept',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                         SizedBox(width: 10),
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
//                             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                           ),
//                           child: Text(
//                             'Reject',
//                             style: TextStyle(fontSize: 18),
//                           ),
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
//
//   Widget _buildField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5),
//         Text(
//           value,
//           style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageField(String label, String imageUrl) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 250,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
