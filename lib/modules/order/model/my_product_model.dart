import 'package:cloud_firestore/cloud_firestore.dart';

class MyProductModel {
  String? productId;
  String? productImage;
  String? productName;
  double? productPrice;

  bool? isPurchase;
  MyProductModel({
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice,
    this.isPurchase,
  });
  MyProductModel.fromSnapshot(DocumentSnapshot data) {
    isPurchase = data['is_purchase'];
    productPrice = data['product_price'] ?? 0.0;
    productId = data['product_id'] ?? '';
    productImage = data['product_image'] ?? '';
    productName = data['product_name'] ?? '';
  }
}
