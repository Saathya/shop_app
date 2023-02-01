import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_spp/Services/firebase_service.dart';

class ReviewCartProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  void addReviewCartData({
    final String? cartName,
    final String? cartId,
    final int? cartPrice,
    final Timestamp? scheduleDate,
    final bool? chargeShipping,
    final int? shippingCharge,
    final Map? seller,
    final String? productId,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(_service.user!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set({
      "cartId": cartId,
      "cartName": cartName,
      "cartPrice": cartPrice,
      "seller": seller,
      "productId": productId,
      "shippingCharge": shippingCharge,
      "chargeShipping": chargeShipping,
      "scheduleDate": scheduleDate,
    });
  }
}
