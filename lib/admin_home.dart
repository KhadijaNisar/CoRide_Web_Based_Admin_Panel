import 'package:flutter/material.dart';
import 'authentication/login.dart';
import 'dashboard_pages/driver_requests_page.dart';
import 'dashboard_pages/drivers_page.dart';
import 'dashboard_pages/passenger_page.dart';
import 'dashboard_pages/vehicle_request_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard_pages/vehicles_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoRide Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'CoRide Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        int crossAxisCount = screenWidth ~/ 200; // Adjust the card width as needed

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('users').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return DashboardCard(
                                    title: 'No of Passengers',
                                    value: 'Error',
                                    icon: Icons.people,
                                    color: Colors.blue,
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return DashboardCard(
                                    title: 'No of Passengers',
                                    value: 'Loading...',
                                    icon: Icons.people,
                                    color: Colors.blue,
                                  );
                                }

                                int numberOfPassengers = snapshot.data!.docs.length;

                                return DashboardCard(
                                  title: 'No of Passengers',
                                  value: '$numberOfPassengers',
                                  icon: Icons.people,
                                  color: Colors.blue,
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('users')
                                  .where('isDriver', isEqualTo: true)
                                  .where('driverStatus', isEqualTo: 'accepted')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return DashboardCard(
                                    title: 'No of Drivers',
                                    value: 'Error',
                                    icon: Icons.directions_car,
                                    color: Colors.green,
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return DashboardCard(
                                    title: 'No of Drivers',
                                    value: 'Loading...',
                                    icon: Icons.directions_car,
                                    color: Colors.green,
                                  );
                                }

                                int numberOfDrivers = snapshot.data!.docs.length;

                                return DashboardCard(
                                  title: 'No of Drivers',
                                  value: '$numberOfDrivers',
                                  icon: Icons.directions_car,
                                  color: Colors.green,
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('users')
                                  .where('isDriver', isEqualTo: true)
                                  .where('driverStatus', isEqualTo: 'requested')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return DashboardCard(
                                    title: 'No of Driver Requests',
                                    value: 'Error',
                                    icon: Icons.request_page,
                                    color: Colors.orange,
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return DashboardCard(
                                    title: 'No of Driver Requests',
                                    value: 'Loading...',
                                    icon: Icons.request_page,
                                    color: Colors.orange,
                                  );
                                }

                                int numberOfDriverRequests = snapshot.data!.docs.length;

                                return DashboardCard(
                                  title: 'No of Driver Requests',
                                  value: '$numberOfDriverRequests',
                                  icon: Icons.request_page,
                                  color: Colors.orange,
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('vehicle_data')
                                  .where('vehicle_status', isEqualTo: 'requested')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return DashboardCard(
                                    title: 'No of Vehicle Requests',
                                    value: 'Error',
                                    icon: Icons.car_rental_outlined,
                                    color: Colors.purple,
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return DashboardCard(
                                    title: 'No of Vehicle Requests',
                                    value: 'Loading...',
                                    icon: Icons.car_rental_outlined,
                                    color: Colors.purple,
                                  );
                                }

                                int numberOfVehicleRequests = snapshot.data!.docs.length;

                                return DashboardCard(
                                  title: 'No of Vehicle Requests',
                                  value: '$numberOfVehicleRequests',
                                  icon: Icons.car_rental_outlined,
                                  color: Colors.purple,
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('vehicle_data')
                                  .where('vehicleStatus', isEqualTo: 'accepted')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return DashboardCard(
                                    title: 'No of Verified Vehicles',
                                    value: 'Error',
                                    icon: Icons.verified_user,
                                    color: Colors.pinkAccent,
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return DashboardCard(
                                    title: 'No of Verified Vehicles',
                                    value: 'Loading...',
                                    icon: Icons.verified_user,
                                    color: Colors.pinkAccent,
                                  );
                                }

                                int numberOfRequestedVehicles = snapshot.data!.docs.length;

                                return DashboardCard(
                                  title: 'No of Verified Vehicles',
                                  value: '$numberOfRequestedVehicles',
                                  icon: Icons.verified_user,
                                  color: Colors.pinkAccent,
                                );
                              },
                            ),

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// class AdminHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           SideMenu(),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'CoRide Dashboard',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         double screenWidth = constraints.maxWidth;
//                         int crossAxisCount = screenWidth ~/ 200; // Adjust the card width as needed
//
//                         return GridView.count(
//                           crossAxisCount: crossAxisCount,
//                           mainAxisSpacing: 16,
//                           crossAxisSpacing: 16,
//                           childAspectRatio: 0.8,
//                           children: [
//                             DashboardCard(
//                               title: 'No of Passengers',
//                               value: '100',
//                               icon: Icons.people,
//                               color: Colors.blue,
//                             ),
//                             DashboardCard(
//                               title: 'No of Drivers',
//                               value: '50',
//                               icon: Icons.directions_car,
//                               color: Colors.green,
//                             ),
//                             DashboardCard(
//                               title: 'No of Driver Requests',
//                               value: '20',
//                               icon: Icons.request_page,
//                               color: Colors.orange,
//                             ),
//                             DashboardCard(
//                               title: 'No of Vehicle Requests',
//                               value: '10',
//                               icon: Icons.car_rental_outlined,
//                               color: Colors.purple,
//                             ),
//                             DashboardCard(
//                               title: 'No of  Verified Vehicles',
//                               value: '10',
//                               icon: Icons.verified_user,
//                               color: Colors.pinkAccent,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      // Handle the case when the user is not logged in
      return Container();
    }

    return Container(
      width: 250,
      child: Drawer(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _firestore
              .collection('admin_user')
              .doc(currentUser.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              );
              // return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              // Handle any errors that occurred during data fetching
              return Text('Error fetching user data');
            }

            final userData = snapshot.data?.data();

            if (userData == null) {
              // Handle the case when the user data is not available
              return Text('User data not found');
            }

            final email = userData['email'] as String?;
            final username = userData['username'] as String?;

            return ListView(
              children: <Widget>[
                Container(
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/coride_high.png',
                          width: 70,
                          height: 70,
                        ),
                        Text(
                          username ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          email ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Passengers'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PassengersPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Drivers'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriversPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user_rounded),
                  title: Text('Verified Vehicles'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VehiclesPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.request_page),
                  title: Text('Driver Requests'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriverRequestsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.car_rental_sharp),
                  title: Text('Vehicle Requests'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VehicleRequestsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                    _logout(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  void _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      print('Failed to log out: $e');
      // Display an error message or handle the error accordingly
    }
  }
}

