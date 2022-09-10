import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;
  Rxn<List<MyProductModel>> productList = Rxn<List<MyProductModel>>();
  List<MyProductModel>? get product => productList.value;
  TextEditingController seaechController = TextEditingController();
  RxString searchProduct = "".obs;
  @override
  void onInit() {
    productList.bindStream(allProductStream());
    super.onInit();
  }

  Stream<List<MyProductModel>> allProductStream() {
    print("enter in all product stream funtion");
    return firstore
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyProductModel> retVal = [];

      query.docs.forEach((element) {
        retVal.add(MyProductModel.fromSnapshot(element));
      });

      print('products lenght is ${retVal.length}');
      return retVal;
    });
  }
}
