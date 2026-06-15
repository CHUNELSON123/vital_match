import 'package:flutter/material.dart';

class TechniciansHeader extends StatelessWidget {

  final VoidCallback onCreate;

  const TechniciansHeader({
    super.key,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        const Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'Technicians',

              style: TextStyle(
                fontSize: 32,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Manage and assign medical laboratory technicians across hospital departments.',
            ),
          ],
        ),

        ElevatedButton.icon(

          onPressed: onCreate,

          icon: const Icon(
            Icons.person_add,
          ),

          label: const Text(
            'Create Technician',
          ),

          style:
              ElevatedButton.styleFrom(
            backgroundColor:
                const Color(
              0xFFDA3433,
            ),
            foregroundColor:
                Colors.white,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}