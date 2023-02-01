import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_spp/Screens/main_screen.dart';

import 'package:shop_spp/Screens/registration_screen.dart';
import 'package:shop_spp/Services/firebase_service.dart';


class LandingScreen extends StatelessWidget {
  static const String id = 'landing-screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: _services.users.doc(_services.user!.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.data!.exists) {
              return const RegistrationScreen();
            }

           

            return const MainScreen();
          }),
    );
  }
}
