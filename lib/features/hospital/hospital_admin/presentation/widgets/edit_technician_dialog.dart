import 'package:flutter/material.dart';
import '../../data/models/technician_table_row.dart';

class EditTechnicianDialog extends StatefulWidget {

  final TechnicianTableRow technician;

  const EditTechnicianDialog({
    super.key,
    required this.technician,
  });

  @override
  State<EditTechnicianDialog> createState() =>
      _EditTechnicianDialogState();
}

class _EditTechnicianDialogState
    extends State<EditTechnicianDialog> {

  late TextEditingController
      fullNameController;

  late TextEditingController
      emailController;

  late TextEditingController
      phoneController;

  late TextEditingController
      employeeIdController;

  late String department;

  late String status;

  @override
  void initState() {
    super.initState();

    fullNameController =
        TextEditingController(
      text:
          widget.technician.user.fullName,
    );

    emailController =
        TextEditingController(
      text:
          widget.technician.user.email,
    );

    phoneController =
        TextEditingController(
      text:
          widget
              .technician
              .user
              .phoneNumber,
    );

    employeeIdController =
        TextEditingController(
      text:
          widget
              .technician
              .technician
              .employeeId,
    );

    department =
        widget
            .technician
            .technician
            .department;

    status =
        widget
            .technician
            .technician
            .status;
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text(
        'Edit Technician',
      ),

      content: SizedBox(
        width: 500,

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller:
                    fullNameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Full Name',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextField(
                controller:
                    emailController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Email',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextField(
                controller:
                    phoneController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Phone Number',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextField(
                controller:
                    employeeIdController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Employee ID',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  String>(
                value: department,

                items: const [

                  DropdownMenuItem(
                    value:
                        'Hematology',
                    child:
                        Text(
                      'Hematology',
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                        'Microbiology',
                    child:
                        Text(
                      'Microbiology',
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                        'Immunology',
                    child:
                        Text(
                      'Immunology',
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                        'Biochemistry',
                    child:
                        Text(
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

              DropdownButtonFormField<
                  String>(
                value: status,

                items: const [

                  DropdownMenuItem(
                    value:
                        'Active',
                    child:
                        Text(
                      'Active',
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                        'Inactive',
                    child:
                        Text(
                      'Inactive',
                    ),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    status =
                        value!;
                  });
                },
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
          child:
              const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {

            Navigator.pop(
              context,
              {
                'fullName':
                    fullNameController.text,

                'email':
                    emailController.text,

                'phoneNumber':
                    phoneController.text,

                'employeeId':
                    employeeIdController.text,

                'department':
                    department,

                'status':
                    status,
              },
            );
          },
          child:
              const Text('Save'),
        ),
      ],
    );
  }
}