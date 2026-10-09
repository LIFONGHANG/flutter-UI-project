import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_project_salait/models/employee_model.dart';
import 'package:flutter_ui_project_salait/screens/employee/employee_service.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({
    super.key,
    this.employee,
  });

  final EmployeeModel? employee;

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final ImagePicker picker = ImagePicker();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneNumberController =
      TextEditingController();

  Uint8List? _selectedImageBytes;

  bool _isPickingImage = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController.text =
        widget.employee?.name ?? '';

    emailController.text =
        widget.employee?.email ?? '';

    phoneNumberController.text =
        widget.employee?.phoneNumber ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  // =========================================================
  // PICK IMAGE
  // =========================================================

  Future<void> pickImage() async {
    if (_isPickingImage) return;

    _isPickingImage = true;

    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 400,
        maxHeight: 400,
      );

      if (image == null) return;

      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedImageBytes = bytes;
      });
    } on PlatformException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ??
                'Unable to open photo library.',
          ),
        ),
      );
    } finally {
      _isPickingImage = false;
    }
  }

  // =========================================================
  // SAVE / UPDATE EMPLOYEE
  // =========================================================

  Future<void> saveEmployee() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String avatar =
          widget.employee?.avatar ?? '';

      if (_selectedImageBytes != null) {
        avatar = base64Encode(
          _selectedImageBytes!,
        );
      }

      final employee = EmployeeModel(
        id: widget.employee?.id,
        avatar: avatar,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber:
            phoneNumberController.text.trim(),
      );

      // CREATE
      if (widget.employee == null) {
        await EmployeeService.createEmployee(
          employee,
        );
      }

      // UPDATE
      else {
        await EmployeeService.updateEmployee(
          employee,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.employee == null
                ? 'Employee created successfully.'
                : 'Employee updated successfully.',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final bool isEditing =
        widget.employee != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit Employee'
              : 'Add Employee',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),

          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // Avatar
                _buildAvatarPicker(),

                const SizedBox(height: 24),

                const Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Basic details about the employee',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                // Name
                _buildTextField(
                  controller: nameController,
                  label: 'Full Name',
                  hintText: 'Enter full name',
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.name,

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter full name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Email
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter email address',
                  icon: Icons.mail_outline,
                  keyboardType:
                      TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter email';
                    }

                    if (!RegExp(
                      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                    ).hasMatch(
                      value.trim(),
                    )) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Phone
                _buildTextField(
                  controller:
                      phoneNumberController,
                  label: 'Phone Number',
                  hintText: 'Enter phone number',
                  icon: Icons.phone_outlined,
                  keyboardType:
                      TextInputType.phone,

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: ElevatedButton.icon(
                    onPressed:
                        _isLoading
                            ? null
                            : saveEmployee,

                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.save,
                          ),

                    label: Text(
                      isEditing
                          ? 'Update Employee'
                          : 'Save Employee',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,

      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  // =========================================================
  // AVATAR
  // =========================================================

  Widget _buildAvatarPicker() {
    ImageProvider? avatarImage;

    // New selected image
    if (_selectedImageBytes != null) {
      avatarImage =
          MemoryImage(_selectedImageBytes!);
    } else {
      // Existing employee image
      final existingAvatar =
          widget.employee?.avatar ?? '';

      if (existingAvatar.isNotEmpty) {
        try {
          avatarImage = MemoryImage(
            base64Decode(existingAvatar),
          );
        } catch (_) {
          avatarImage = null;
        }
      }
    }

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor:
                Colors.grey.shade300,
            backgroundImage: avatarImage,

            child: avatarImage == null
                ? const Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.white,
                  )
                : null,
          ),

          Positioned(
            bottom: 0,
            right: 0,

            child: InkWell(
              onTap: pickImage,
              borderRadius:
                  BorderRadius.circular(30),

              child: Container(
                width: 42,
                height: 42,

                decoration:
                    const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}