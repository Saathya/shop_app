import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool?,
          name: json['name']! as String?,
          city: json['city']! as String?,
          state: json['state']! as String?,
          country: json['country']! as String?,
          email: json['email']! as String?,
          landMark: json['landMark']! as String?,
          shopImage: json['shopImage']! as String?,
          mobile: json['mobile']! as String?,
          pinCode: json['pinCode']! as String?,
          time: json['time']! as Timestamp?,
          uid: json['uid']! as String?,
        );

  final bool? approved;
  final String? name;
  final String? city;
  final String? state;
  final String? country;

  final String? email;
  final String? landMark;

  final String? shopImage;
  final String? mobile;
  final String? pinCode;

  final Timestamp? time;
  final String? uid;
  final String? userId;

  Users(
      {this.approved,
      this.name,
      this.city,
      this.state,
      this.country,
      this.email,
      this.landMark,
      this.shopImage,
      this.mobile,
      this.pinCode,
      this.time,
      this.uid,
      this.userId});

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': name,
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'Landmark': landMark,
      'shopImage': shopImage,
      'mobile': mobile,
      'pinCode': pinCode,
      'time': time,
      'uid': uid,
    };
  }
}
