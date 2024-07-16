import 'package:coride_admin/admin_home.dart';
import 'package:coride_admin/authentication/login.dart';
import 'package:coride_admin/authentication/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyBnEN_M-uvnHhiRqSQewZBU5iTV2e9PxfU",
  //     appId: "1:632782991611:web:4a5ba45ca25b8c2f0a405e",
  //     messagingSenderId: "632782991611",
  //     projectId: "poolingapp-409408",
  //   ),
  // );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if the authentication state is still loading
            return CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data != null) {
            // User is logged in, navigate to the home page
            return AdminHomePage();
          } else {
            // User is not logged in, show the login page
            return LoginScreen();
          }
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: LoginScreen(),
//       // home: SignupScreen(),
//     );
//   }
// }
