import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;
  Rxn<List<MyProductModel>> productList = Rxn<List<MyProductModel>>();
  List<MyProductModel>? get product => productList.value;

  @override
  void onInit() {
    productList.bindStream(myCartStream());
    super.onInit();
  }

  Stream<List<MyProductModel>> myCartStream() {
    print("enter in all product stream funtion");
    print('id is:${auth.currentUser!.uid}');
    return firstore
        .collection('Customer')
        .doc(auth.currentUser!.uid)
        .collection("add_to_cart")
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyProductModel> retVal = [];
      // print("query is:${query.docs.first.data()}");

      query.docs.forEach((element) {
        retVal.add(MyProductModel.fromSnapshot(element));
      });

      print('cart lenght is ${retVal.length}');
      return retVal;
    });
  }
}
