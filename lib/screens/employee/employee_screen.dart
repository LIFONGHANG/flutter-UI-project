// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter2026/Const/colors.dart';
// import 'package:flutter2026/model/employee_model.dart';
// import 'package:flutter2026/screen/employee/employee_service.dart';
// import 'package:flutter2026/widget/btn_cs.dart';

// class EmployeeScreen extends StatelessWidget {
//   const EmployeeScreen({super.key});

//   Future<void> confirmDelete(
//     BuildContext context,
//     EmployeeModel employee,
//   ) async {
//     final confrimed = await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog.adaptive(
//           title: Text(
//             "Delete Employee",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),

//           content: Text("Are you sure, You want to delete ${employee.name}? "),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               style: TextButton.styleFrom(foregroundColor: redColor),
//               child: Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );

//     if (confrimed == true) {
//       await EmployeeService.deleteEmployee(employee.id ?? "");
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Employee delete successfully."),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         label: Text("Add Employee"),
//         onPressed: () =>
//             Navigator.pushNamed(context, "/add-employee", arguments: null),
//         icon: Icon(Icons.add),
//       ),
//       appBar: AppBar(title: Text("Employee-List")),
//       body: StreamBuilder(
//         stream: EmployeeService.getEmployees(),
//         builder: (context, snap) {
//           //Check Loading
//           if (snap.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           //Check Error
//           if (snap.hasError) {
//             return Column(
//               children: [
//                 Icon(Icons.error, size: 50, color: redColor),
//                 Text(
//                   "Error something",
//                   style: TextStyle(color: textSecondaryColor),
//                 ),
//               ],
//             );
//           }

//           //Check has data or list employees is not empty

//           final employees = snap.data ?? [];
//           if (employees.isEmpty) {
//             return Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.person, size: 50, color: textSecondaryColor),
//                   Text(
//                     "No employees yet.\n Tap + Add Employee one.",
//                     style: TextStyle(color: textSecondaryColor),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (context, index) {
//               final employee = employees[index];
//               return ListTile(
//                 leading: _buildAvatarPickImage(employee.avatar),
//                 // Icon(Icons.person, size: 36),
//                 title: Text(employee.name),
//                 subtitle: Text("${employee.email} | ${employee.phoneNumber}"),
//                 trailing: SizedBox(
//                   width: 100,
//                   child: Row(
//                     children: [
//                       BtnCs(
//                         onTap: () => confirmDelete(context, employee),
//                         icon: Icons.delete,
//                         color: redColor,
//                         colorIcon: whiteColor,
//                       ),
//                       BtnCs(
//                         onTap: () => Navigator.pushNamed(
//                           context,
//                           "/add-employee",
//                           arguments: employee,
//                         ),
//                         icon: Icons.edit,
//                         color: Colors.blue,
//                         colorIcon: whiteColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAvatarPickImage(String profileImage) {
//     return CircleAvatar(
//       radius: 30,
//       backgroundColor: Colors.grey.shade300,
//       backgroundImage: profileImage.isNotEmpty
//           ? FileImage(File(profileImage))
//           : null,
//       child: profileImage.isEmpty
//           ? Icon(Icons.person, size: 45, color: Colors.grey.shade200)
//           : null,
//     );
//   }
// }
