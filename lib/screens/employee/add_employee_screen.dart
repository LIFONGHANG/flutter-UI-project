// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter2026/Const/colors.dart';
// import 'package:flutter2026/model/employee_model.dart';
// import 'package:flutter2026/screen/employee/employee_service.dart';
// import 'package:flutter2026/widget/btn_cs.dart';
// import 'package:flutter2026/widget/employee/employee_form_widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class AddEmployeeScreen extends StatefulWidget {
//   const AddEmployeeScreen({super.key, this.employee});

//   final EmployeeModel? employee;

//   @override
//   State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
// }

// class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
//   XFile? _selectedImage;

//   final ImagePicker picker = ImagePicker();
//   bool _isPickingImage = false;
//   bool _isLoading = false;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   Future<void> pickImage() async {
//     if (_isPickingImage) return;
//     _isPickingImage = true;
//     try {
//       final image = await picker.pickImage(source: ImageSource.gallery);
//       if (!mounted || image == null) return;
//       setState(() {
//         _selectedImage = image;
//       });
//     } on PlatformException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? "Unale to open photo library.")),
//       );
//     } finally {
//       _isPickingImage = false;
//     }
//   }

//   Future<void> _saveEmployee() async {
//     if (!formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);
//     try {
//       final employee = EmployeeModel(
//         id: widget.employee?.id,
//         avatar: _selectedImage!.path,
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         phoneNumber: phoneNumberController.text.trim(),
//       );

//       if (widget.employee == null) {
//         await EmployeeService.createEmployee(employee);
//         _showSnackBar("Employee create successfully", Colors.green);
//       } else {
//         await EmployeeService.updateEmployee(employee);
//       }
//       if (!mounted) return;
//       Navigator.pop(context);
//     } catch (e) {
//       _showSnackBar("Error : $e", redColor);
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showSnackBar(String message, Color color) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
//   }

//   @override
//   void initState() {
//     if (_selectedImage != null) {
//       _selectedImage = XFile(widget.employee?.avatar ?? "");
//     }
//     nameController.text = widget.employee?.name ?? "";
//     emailController.text = widget.employee?.email ?? "";
//     phoneNumberController.text = widget.employee?.phoneNumber ?? "";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add Employee',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF10212B),
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: const EdgeInsets.all(16),
//           child: Center(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 spacing: 8,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildAvatarPickImage(),
//                   EmployeeFormSection(
//                     title: 'Personal Information',
//                     subtitle: 'Basic details about the employee',
//                     child: Column(
//                       spacing: 18,
//                       children: [
//                         EmployeeTextField(
//                           label: 'Full Name',
//                           hintText: 'Enter full name',
//                           icon: Icons.person_outline,
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           autofillHints: const [AutofillHints.name],
//                         ),

//                         EmployeeTextField(
//                           label: 'Email',
//                           hintText: 'Enter email address',
//                           icon: Icons.mail_outline,
//                           controller: emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           autofillHints: const [AutofillHints.email],
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter email';
//                             }
//                             if (!RegExp(
//                               r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
//                             ).hasMatch(value.trim())) {
//                               return 'Please enter a valid email address';
//                             }
//                             return null;
//                           },
//                         ),

//                         EmployeeTextField(
//                           label: 'Phone Number',
//                           hintText: 'Enter phone number',
//                           icon: Icons.phone_outlined,
//                           controller: phoneNumberController,
//                           keyboardType: TextInputType.phone,
//                           textInputAction: TextInputAction.done,
//                           autofillHints: const [AutofillHints.telephoneNumber],
//                         ),
//                       ],
//                     ),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: SizedBox(
//                       height: 45,
//                       child: BtnCs(
//                         onTap: () => _saveEmployee(),
//                         icon: Icons.save,
//                         fontSize: 16,
//                         buttonName: widget.employee == null
//                             ? "Save Employee"
//                             : "Update Employee",
//                         color: widget.employee == null
//                             ? Colors.blue
//                             : Colors.deepOrange,
//                         colorText: whiteColor,
//                         colorIcon: whiteColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatarPickImage() {
//     return Center(
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: 60,
//             backgroundColor: Colors.grey.shade300,
//             backgroundImage: _selectedImage != null
//                 ? FileImage(File(_selectedImage!.path))
//                 : FileImage(File(widget.employee?.avatar ?? "")),
//             child: _selectedImage == null && widget.employee == null
//                 ? Icon(Icons.person, size: 80, color: Colors.grey.shade200)
//                 : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: BtnCs(
//               icon: Icons.camera_alt_rounded,
//               onTap: () => pickImage(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
