import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCartModel {
  final String? cartName;
  final String? cartId;
  final String? cartImage;
  final int? cartPrice;
  final Timestamp? scheduleDate;
  final bool? chargeShipping;
  final int? shippingCharge;
  final Map? seller;
  final String? productId;

  ReviewCartModel(
      {this.cartName,
      this.cartId,
      this.cartImage,
      this.cartPrice,
      this.scheduleDate,
      this.chargeShipping,
      this.shippingCharge,
      this.seller,
      this.productId});
}
