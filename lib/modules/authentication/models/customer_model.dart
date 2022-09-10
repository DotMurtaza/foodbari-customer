import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  GeoPoint? location;
  String? address;
  String? profileImage;
  CustomerModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.location,
      this.profileImage,
      this.address});

  CustomerModel.fromSnapshot(DocumentSnapshot data) {
    id = data.id;
    address = data["address"] ?? '';
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    phone = data['phone'] ?? '';
    location = data['location'] ?? '';
    profileImage = data['profileImage'] ?? '';
  }
}
