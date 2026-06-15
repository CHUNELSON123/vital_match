import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class TechniciansTable extends StatelessWidget {

  final List<LabTechnician>
      technicians;

  const TechniciansTable({
    super.key,
    required this.technicians,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color:
              const Color(0xFFE5E5E5),
        ),
      ),

      child: DataTable(

        columns: const [

          DataColumn(
            label: Text(
              'Technician ID',
            ),
          ),

          DataColumn(
            label: Text(
              'Employee ID',
            ),
          ),

          DataColumn(
            label: Text(
              'Department',
            ),
          ),

          DataColumn(
            label: Text(
              'Actions',
            ),
          ),
        ],

        rows:
            technicians.map((tech) {

          return DataRow(

            cells: [

              DataCell(
                Text(
                  tech.technicianId,
                ),
              ),

              DataCell(
                Text(
                  tech.employeeId,
                ),
              ),

              DataCell(
                Text(
                  tech.department,
                ),
              ),

              DataCell(

                Row(

                  children: [

                    IconButton(
                      icon:
                          const Icon(
                        Icons.edit,
                      ),
                      onPressed: () {},
                    ),

                    IconButton(
                      icon:
                          const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}