import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/user_model.dart';
import '../Services/firebase_service.dart';


class UserProvider with ChangeNotifier {
  DocumentSnapshot? doc;
  Users? user;
  final FirebaseService _services = FirebaseService();
  getUserData() {
    _services.users.doc(_services.user!.uid).get().then((document) {
      doc = document;
      user = Users.fromJson(document.data() as Map<String, dynamic>);
      notifyListeners();
    });
  }
}
