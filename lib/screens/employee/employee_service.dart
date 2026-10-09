import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui_project_salait/models/employee_model.dart';

class EmployeeService {
  static final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('employee');

  static Stream<List<EmployeeModel>> getEmployees() {
    return _col.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => EmployeeModel.fromDocument(doc))
          .toList(),
    );
  }

  static Future<void> createEmployee(EmployeeModel employee) async {
    await _col.add(employee.toJson());
  }

  static Future<void> updateEmployee(EmployeeModel employee) async {
    if (employee.id == null) {
      throw Exception('Employee ID is missing.');
    }

    await _col.doc(employee.id).update(employee.toJson());
  }

  static Future<void> deleteEmployee(String employeeId) async {
    await _col.doc(employeeId).delete();
  }
}