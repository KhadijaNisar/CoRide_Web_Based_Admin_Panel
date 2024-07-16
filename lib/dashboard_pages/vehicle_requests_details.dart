import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../admin_home.dart';

class VehiclesDetailScreen extends StatefulWidget {
  final DocumentSnapshot vehicleData;
  final String documentId;

  VehiclesDetailScreen({required this.vehicleData,required this.documentId});

  @override
  State<VehiclesDetailScreen> createState() => _VehiclesDetailScreenState();
}

class _VehiclesDetailScreenState extends State<VehiclesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final vehicleData = widget.vehicleData.data() as Map<String, dynamic>;

    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Vehicle Type',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildVehicleType(vehicleData['vehicleType']),
                    SizedBox(height: 20),
                    Text(
                      'Vehicle Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildVehicleField('Brand', vehicleData['brand']),
                    _buildVehicleField('Color', vehicleData['color']),
                    // _buildVehicleField('License Image URL', vehicleData['licenseImageUrl']),
                    _buildImageField('License Image',vehicleData['licenseImageUrl']),
                    _buildVehicleField('Model', vehicleData['model']),
                    _buildVehicleField('Registration Number', vehicleData['registrationNumber']),
                    // _buildVehicleField('Vehicle File URL', vehicleData['vehicleFileUrl']),
                    _buildImageField('Vehicle File Image',vehicleData['vehicleFileUrl']),
                    // _buildVehicleField('Vehicle Image URL', vehicleData['vehicleImageUrl']),
                    _buildImageField('Vehicle Image',vehicleData['vehicleImageUrl']),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Accept action
                            FirebaseFirestore.instance
                                .collection('vehicle_data')
                                .doc(widget.documentId)
                                .update({'vehicleStatus': 'accepted'})
                                .then((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminHomePage(),
                                ),
                              );
                            }).catchError((error) {
                              // Handle error if the update fails
                              print('Failed to update vehicle status: $error');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text('Accept',style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: () {
                            // Reject action
                            FirebaseFirestore.instance
                                .collection('vehicle_data')
                                .doc(widget.documentId)
                                .delete()
                                .then((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminHomePage(),
                                ),
                              );
                            }).catchError((error) {
                              // Handle error if the deletion fails
                              print('Failed to delete vehicle document: $error');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          // ... button properties
                          child: Text('Reject' ,style: TextStyle(fontSize: 18, color: Colors.white)),
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

  Widget _buildVehicleType(String type) {
    IconData icon;
    String text;

    switch (type) {
      case 'Car':
        icon = Icons.directions_car;
        text = 'Car';
        break;
      case 'Rickshaw':
        icon = Icons.directions_bike;
        text = 'Rickshaw';
        break;
      case 'Motorcycle':
        icon = Icons.motorcycle;
        text = 'Motorcycle';
        break;
      default:
        icon = Icons.directions_car;
        text = 'Unknown';
    }

    return Row(
      children: [
        Icon(icon, size: 40),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildVehicleField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
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