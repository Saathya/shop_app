import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference banner = FirebaseFirestore.instance.collection('banner');
  CollectionReference productAd =
      FirebaseFirestore.instance.collection('productAd');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference maincat =
      FirebaseFirestore.instance.collection('maincategories');
  CollectionReference vendor = FirebaseFirestore.instance.collection('vendors');

  String formatedNumber(number) {
    var f = NumberFormat('#,##,###');
    String formattedNumber = f.format(number);
    return formattedNumber;
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImage(XFile? file, String? reference) async {
    File _file = File(file!.path);
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(reference);

    await ref.putFile(_file);

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> addUser({Map<String, dynamic>? data}) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(user!.uid)
        .set(data)
        // ignore: avoid_print
        .then((value) => print("User Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

  String formatedDate(date) {
    var outPutFormate = DateFormat('dd/MM/yyyy');
    var outputDate = outPutFormate.format(date);
    return outputDate;
  }

  Widget formField(
      {String? label,
      TextInputType? inputType,
      void Function(String)? onChanged,
      int? minLines,
      int? maxLines}) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        label: Text(label!),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return label;
        }
        return null;
      },
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
    );
  }

  scaffold(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
    ));
  }

}
