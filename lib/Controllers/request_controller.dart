import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/Models/all_request_model.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class RequestController extends GetxController {
  File? requestImage;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CustomerController customerController = Get.put(CustomerController());

  Future<void> submitRequest(context) async {
    Utils.showLoadingDialog(context, text: "Sending Request...");
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('customer-request-images')
          .child(customerController.auth.currentUser!.uid);
      await ref.putFile(requestImage!);
      final url = await ref.getDownloadURL();
      Map<String, dynamic> requestData = {
        'request_image': url,
        'title': titleController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'status': "Pending",
        "time": Timestamp.now(),
        "customer_id": customerController.auth.currentUser!.uid,
        "customer_name": customerController.customerModel.value!.name,
        "customer_address": customerController.customerModel.value!.address,
        "customer_location": customerController.customerModel.value!.location,
        "no_of_request": 0,
        "customer_image": customerController
                    .customerModel.value!.profileImage ==
                ""
            ? "https://cdn.techjuice.pk/wp-content/uploads/2015/02/wallpaper-for-facebook-profile-photo-1024x645.jpg"
            : customerController.customerModel.value!.profileImage,
        "delivery_boy_id": ""
      };
      await _firestore.collection('all_requests').add(requestData);
      Get.back();
      Utils.showCustomDialog(context,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  const Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    color: Colors.green,
                  ),
                  const Text("Request Send"),
                  TextButton(
                      onPressed: () {
                        requestImage = null;
                        titleController.clear();
                        descriptionController.clear();
                        priceController.clear();
                        Get.back();
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ));
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString().split("] ").last);
    }
  }

  Rxn<List<AllRequestModel>> offerList = Rxn<List<AllRequestModel>>();
  List<AllRequestModel>? get offers => offerList.value;
  @override
  void onInit() {
    offerList.bindStream(receiveOfferStream());
    super.onInit();
  }

  Stream<List<AllRequestModel>> receiveOfferStream() {
    print("receive offer stream funtion");
    return _firestore
        .collection('all_requests')
        .where("customer_id", isEqualTo: customerController.user!.uid)
        .where("status", isEqualTo: "Requested")
        .snapshots()
        .map((QuerySnapshot query) {
      List<AllRequestModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(AllRequestModel.fromSnapshot(element));
      }

      debugPrint('offer receive  lenght is ${retVal.length}');
      return retVal;
    });
  }
}
