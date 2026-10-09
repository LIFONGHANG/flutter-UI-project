import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String? id;
  final String avatar;
  final String name;
  final String email;
  final String phoneNumber;

  const EmployeeModel({
    this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory EmployeeModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return EmployeeModel(
      id: doc.id,
      avatar: data['avatar'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}