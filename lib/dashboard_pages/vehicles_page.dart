import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_home.dart';

class VehiclesPage extends StatelessWidget {
  final CollectionReference vehiclesCollection =
  FirebaseFirestore.instance.collection('vehicle_data');

  void _deleteVehicle(BuildContext context, String documentId) {
    // Update the Firestore document
    FirebaseFirestore.instance
        .collection('vehicle_data')
        .doc(documentId)
        .delete()
        .then((_) {
      // Show a success message or perform any additional actions
      print('Vehicle deleted successfully');
    }).catchError((error) {
      // Show an error message or handle the error
      print('Failed to delete vehicle: $error');
    });
  }

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
                    'Verified Vehicles',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: vehiclesCollection
                        .where('vehicleStatus', isEqualTo: 'accepted')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error fetching vehicles');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final vehicles = snapshot.data?.docs ?? [];
                      final verifiedVehicleCount = vehicles.length;

                      return Text(
                        '$verifiedVehicleCount Drivers Registered',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: vehiclesCollection
                        .where('vehicleStatus', isEqualTo: 'accepted')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error fetching vehicles');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final vehicles = snapshot.data?.docs ?? [];
                      final verifiedVehicleCount = vehicles.length;

                      return verifiedVehicleCount > 0
                          ?
                      Expanded(
                        child: ListView.builder(
                          itemCount: vehicles.length,
                          itemBuilder: (context, index) {
                            final vehicle =
                            vehicles[index].data() as Map<String,
                                dynamic>;
                            return VehicleCard(
                              vehicle: vehicle,
                              onDelete: () {
                                _deleteVehicle(
                                    context, vehicles[index].id);
                              },
                            );
                          },
                        ),
                      )
                          : Text(
                        'No Verified Vehicles',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
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

class VehicleCard extends StatelessWidget {
  final Map<String, dynamic>? vehicle;
  final VoidCallback onDelete;

  const VehicleCard({
    required this.vehicle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (vehicle == null) {
      return Container();
    }
    final String vehicleImageUrl = vehicle!['vehicleImageUrl'] ?? '';
    final String brand = vehicle!['brand'] ?? '';
    final String vehicleType = vehicle!['vehicleType'] ?? '';
    final String color = vehicle!['color'] ?? '';
    final String licenseImageUrl = vehicle!['licenseImageUrl'] ?? '';
    final String model = vehicle!['model'] ?? '';
    final String registrationNumber = vehicle!['registrationNumber'] ?? '';
    final String vehicleFileUrl = vehicle!['vehicleFileUrl'] ?? '';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(vehicleImageUrl),
              radius: 24,
            ),
            SizedBox(width: 16),
            Text(
              '$brand $vehicleType',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        children: [
          ListTile(
            title: Text(
              'Brand',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(
              brand,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Vehicle Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(
              vehicleType,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Color',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(
              color,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Model',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(
              model,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Registration Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(
              registrationNumber,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'License Image',
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
                            licenseImageUrl,
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
                        'Vehicle File',
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
                           vehicleFileUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
          // ListTile(
          //   title: Text(
          //     'License Image URL',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.green,
          //     ),
          //   ),
          //   subtitle: Text(
          //     licenseImageUrl,
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          // ListTile(
          //   title: Text(
          //     'Vehicle File URL',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.green,
          //     ),
          //   ),
          //   subtitle: Text(
          //     vehicleFileUrl,
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../admin_home.dart';
//
// class VehiclesPage extends StatelessWidget {
//   final CollectionReference vehiclesCollection =
//   FirebaseFirestore.instance.collection('vehicle_data');
//
//   void _deleteVehicle(BuildContext context, String documentId) {
//     // Update the Firestore document
//     FirebaseFirestore.instance
//         .collection('vehicle_data')
//         .doc(documentId)
//         .delete()
//         .then((_) {
//       // Show a success message or perform any additional actions
//       print('Vehicle deleted successfully');
//     }).catchError((error) {
//       // Show an error message or handle the error
//       print('Failed to delete vehicle: $error');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           SideMenu(),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   Text(
//                     'Verified Vehicles',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   StreamBuilder<QuerySnapshot>(
//                     stream: vehiclesCollection
//                         .where('vehicleStatus', isEqualTo: 'accepted')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Text('Error fetching vehicles');
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//
//                       final vehicles = snapshot.data?.docs ?? [];
//
//                       return ListView.builder(
//                         itemCount: vehicles.length,
//                         itemBuilder: (context, index) {
//                           final vehicle =
//                           vehicles[index].data() as Map<String, dynamic>;
//                           return VehicleCard(
//                             vehicle: vehicle,
//                             onDelete: () {
//                               _deleteVehicle(context, vehicles[index].id);
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VehicleCard extends StatelessWidget {
//   final Map<String, dynamic>? vehicle;
//   final VoidCallback onDelete;
//
//   const VehicleCard({
//     required this.vehicle,
//     required this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (vehicle == null) {
//       return Container();
//     }
//     final String vehicleImageUrl = vehicle!['vehicleImageUrl'] ?? '';
//     final String brand = vehicle!['brand'] ?? '';
//     final String vehicleType = vehicle!['vehicleType'] ?? '';
//     final String color = vehicle!['color'] ?? '';
//     final String licenseImageUrl = vehicle!['licenseImageUrl'] ?? '';
//     final String model = vehicle!['model'] ?? '';
//     final String registrationNumber = vehicle!['registrationNumber'] ?? '';
//     final String vehicleFileUrl = vehicle!['vehicleFileUrl'] ?? '';
//
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ExpansionTile(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(vehicleImageUrl),
//               radius: 24,
//             ),
//             SizedBox(width: 16),
//             Text(
//               '$brand $vehicleType',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         children: [
//           ListTile(
//             title: Text(
//               'Brand',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               brand,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Vehicle Type',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               vehicleType,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Color',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               color,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'License Image URL',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               licenseImageUrl,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Model',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               model,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Registration Number',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               registrationNumber,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Vehicle File URL',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             subtitle: Text(
//               vehicleFileUrl,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: onDelete,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
