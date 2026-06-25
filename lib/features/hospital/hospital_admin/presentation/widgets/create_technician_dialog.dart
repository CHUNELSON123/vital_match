import 'package:flutter/material.dart';

class CreateTechnicianDialog extends StatefulWidget {
  const CreateTechnicianDialog({
    super.key,
  });

  @override
  State<CreateTechnicianDialog>
      createState() =>
          _CreateTechnicianDialogState();
}

class _CreateTechnicianDialogState
    extends State<CreateTechnicianDialog> {
  final formKey = GlobalKey<FormState>();

  final employeeIdController =
      TextEditingController();

  final userEmailController =
      TextEditingController();

  final fullNameController =
    TextEditingController();

final phoneNumberController =
    TextEditingController();

  String department =
      'Hematology';

  @override
  void dispose() {
    employeeIdController.dispose();
    userEmailController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text(
        'Create Technician',
      ),

      content: SizedBox(
        width: 500,

        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

            TextFormField(
              controller:
                  employeeIdController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Employee ID is required';
                }

                return null;
              },

              decoration:
                  const InputDecoration(
                labelText:
                    'Employee ID',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextFormField(
              controller: fullNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name is required';
                }

                if (value.trim().length < 3) {
                  return 'Full name must be at least 3 characters';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<
                String>(
                initialValue: department,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Department is required';
                }

                return null;
              },

              items: const [

                DropdownMenuItem(
                  value:
                      'Hematology',
                  child: Text(
                    'Hematology',
                  ),
                ),

                DropdownMenuItem(
                  value:
                      'Microbiology',
                  child: Text(
                    'Microbiology',
                  ),
                ),

                DropdownMenuItem(
                  value:
                      'Immunology',
                  child: Text(
                    'Immunology',
                  ),
                ),

                DropdownMenuItem(
                  value:
                      'Biochemistry',
                  child: Text(
                    'Biochemistry',
                  ),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  department =
                      value!;
                });
              },
            ),

            const SizedBox(
              height: 16,
            ),

            TextFormField(
              controller:
                  userEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final email = value?.trim() ?? '';

                if (email.isEmpty) {
                  return 'Email is required';
                }

                final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

                if (!emailRegex.hasMatch(email)) {
                  return 'Enter a valid email';
                }

                return null;
              },

              decoration:
                  const InputDecoration(
                labelText:
                    'User Email',
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                final phone = value?.trim() ?? '';

                if (phone.isEmpty) {
                  return 'Phone number is required';
                }

                final phoneRegex = RegExp(r'^(\+237\s?)?6\d{8}$');

                if (!phoneRegex.hasMatch(phone)) {
                  return 'Enter a valid Cameroon phone number';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            ],
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text(
            'Cancel',
          ),
        ),

        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            Navigator.pop(
              context,
               {
                'fullName':
                    fullNameController.text.trim(),

                'email':
                    userEmailController.text.trim(),

                'phoneNumber':
                    phoneNumberController.text.trim(),

                'employeeId':
                    employeeIdController.text.trim(),

                'department':
                    department,
              }
            );
          },
          child: const Text(
            'Create',
          ),
        ),
      ],
    );
  }
}
