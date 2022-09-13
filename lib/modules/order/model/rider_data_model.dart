import 'package:cloud_firestore/cloud_firestore.dart';

class RiderDataModel {
  String? id;
  String? rider_address;
  String? rider_email;
  GeoPoint? rider_location;
  String? rider_name;
  String? rider_phone;
  RiderDataModel({
    this.id,
    this.rider_address,
    this.rider_email,
    this.rider_location,
    this.rider_name,
    this.rider_phone,
  });
  RiderDataModel.fromSnapshot(DocumentSnapshot data) {
    id = data.id;
    rider_address = data['rider_address'] ?? '';
    rider_email = data['rider_email'] ?? '';
    rider_location = data['rider_location'] ?? '';
    rider_name = data['rider_name'] ?? '';
    rider_phone = data['rider_phone'] ?? '';
  }
}
