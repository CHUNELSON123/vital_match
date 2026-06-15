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

  final employeeIdController =
      TextEditingController();

  final userEmailController =
      TextEditingController();

  String department =
      'Hematology';

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text(
        'Create Technician',
      ),

      content: SizedBox(
        width: 500,

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [

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

            TextField(
              controller:
                  userEmailController,

              decoration:
                  const InputDecoration(
                labelText:
                    'User Email',
              ),
            ),
          ],
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

            Navigator.pop(
              context,
              {
                'employeeId':
                    employeeIdController
                        .text,
                'department':
                    department,
                'email':
                    userEmailController
                        .text,
              },
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