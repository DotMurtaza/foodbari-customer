import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceOrderModel {
  String? id;
  String? is_purchase;
  String? product_image;
  String? product_id;
  String? product_name;
  String? product_price;
  PlaceOrderModel({
    this.id,
    this.is_purchase,
    this.product_image,
    this.product_id,
    this.product_name,
    this.product_price,
  });
  PlaceOrderModel.fromSnapshot(DocumentSnapshot data) {
    print("is_purchase is:$product_id");
    id = data.id;
    is_purchase = data['is_purchased'] ?? '';
    product_image = data['prduct_image'] ?? '';
    product_id = data['product_id'] ?? '';
    product_name = data['product_name'] ?? '';
    product_price = data['product_price'] ?? '';
  }
}
