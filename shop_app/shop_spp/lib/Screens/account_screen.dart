import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:multi_shop_app/Screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account-screen";
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Account Screen",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
