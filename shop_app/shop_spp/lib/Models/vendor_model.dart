import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  Vendor.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool?,
          businessName: json['businessName']! as String?,
          city: json['city']! as String?,
          state: json['state']! as String?,
          category: json['category']! as String,
          country: json['country']! as String?,
          email: json['email']! as String?,
          landMark: json['landMark']! as String?,
          logo: json['logo']! as String?,
          shopImage: json['shopImage']! as String?,
          mobile: json['mobile']! as String?,
          pinCode: json['pinCode']! as String?,
          taxRegistered: json['taxRegistered']! as String?,
          gstinNumber: json['gstinNumber']! as String?,
          time: json['time']! as Timestamp?,
          uid: json['uid']! as String?,
        );

  final bool? approved;
  final String? businessName;
  final String? city;
  final String? state;
  final String? country;
  final String? category;
  final String? email;
  final String? landMark;
  final String? logo;
  final String? shopImage;
  final String? mobile;
  final String? pinCode;
  final String? taxRegistered;
  final String? gstinNumber;
  final Timestamp? time;
  final String? uid;
   final String? vendorId;
  Vendor({
    this.approved,
    this.businessName,
    this.city,
    this.state,
    this.country,
    this.category,
    this.email,
    this.landMark,
    this.logo,
    this.shopImage,
    this.mobile,
    this.pinCode,
    this.taxRegistered,
    this.gstinNumber,
    this.time,
    this.uid,
    this.vendorId,
  });

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'city': city,
      'state': state,
      'category': category,
      'country': country,
      'email': email,
      'Landmark': landMark,
      'logo': logo,
      'shopImage': shopImage,
      'mobile': mobile,
      'pinCode': pinCode,
      'taxRegistered': taxRegistered,
      'gstin Number': gstinNumber,
      'time': time,
      'uid': uid,
    };
  }
}

vendorQuery({category,vendorId}) {
  return FirebaseFirestore.instance
      .collection('vendors')
      .where('approved', isEqualTo: true)
      .where('category', isEqualTo: category)
      .withConverter<Vendor>(
        fromFirestore: (snapshot, _) => Vendor.fromJson(snapshot.data()!),
        toFirestore: (vendor, _) => vendor.toJson(),
      );
}
