import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui_project_salait/models/employee_model.dart';
import 'package:flutter_ui_project_salait/screens/employee/add_employee_screen.dart';
import 'package:flutter_ui_project_salait/screens/employee/employee_service.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  Future<void> confirmDelete(
    BuildContext context,
    EmployeeModel employee,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Employee',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${employee.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && employee.id != null) {
      await EmployeeService.deleteEmployee(employee.id!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee deleted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void openAddEmployee(
    BuildContext context, {
    EmployeeModel? employee,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEmployeeScreen(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openAddEmployee(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Employee'),
      ),

      body: StreamBuilder<List<EmployeeModel>>(
        stream: EmployeeService.getEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final employees = snapshot.data ?? [];

          if (employees.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 8),

                  Text(
                    'No employees yet.\nTap + Add Employee to create one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(
              bottom: 90,
            ),
            itemCount: employees.length,

            separatorBuilder: (context, index) {
              return const Divider(height: 1);
            },

            itemBuilder: (context, index) {
              final employee = employees[index];

              return ListTile(
                leading: _buildAvatar(employee.avatar),

                title: Text(
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                subtitle: Text(
                  '${employee.email}\n${employee.phoneNumber}',
                ),

                isThreeLine: true,

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit
                    IconButton(
                      onPressed: () => openAddEmployee(
                        context,
                        employee: employee,
                      ),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),

                    // Delete
                    IconButton(
                      onPressed: () {
                        confirmDelete(
                          context,
                          employee,
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(String avatar) {
    if (avatar.isEmpty) {
      return const CircleAvatar(
        radius: 28,
        child: Icon(Icons.person),
      );
    }

    try {
      final bytes = base64Decode(avatar);

      return CircleAvatar(
        radius: 28,
        backgroundImage: MemoryImage(bytes),
      );
    } catch (_) {
      return const CircleAvatar(
        radius: 28,
        child: Icon(Icons.person),
      );
    }
  }
}