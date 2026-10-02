// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter2026/model/employee_model.dart';

// class EmployeeService {
//   static final _col = FirebaseFirestore.instance.collection("employee");

//   static Stream<List<EmployeeModel>> getEmployees() {
//     return _col.snapshots().map(
//       (snapshote) =>
//           snapshote.docs.map((doc) => EmployeeModel.fromDocument(doc)).toList(),
//     );
//   }

//   static Future<void> createEmployee(EmployeeModel employee) async {
//     await _col.add(employee.toJson());
//   }

//   static Future<void> updateEmployee(EmployeeModel employee) async {
//     print("====asdfasdf===${employee.id}");
//     await _col.doc(employee.id).update({
//       "avatar": employee.avatar,
//       "name": employee.name,
//       "email": employee.email,
//       "phone_number": employee.phoneNumber,
//     });
//   }

//   static Future<void> deleteEmployee(String employeeID) async {
//     await _col.doc(employeeID).delete();
//   }
// }
