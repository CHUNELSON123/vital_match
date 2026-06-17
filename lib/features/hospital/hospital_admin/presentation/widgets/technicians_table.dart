import 'package:flutter/material.dart';
import '../../data/models/technician_table_row.dart';

class TechniciansTable extends StatelessWidget {
  final List<TechnicianTableRow> technicians;

  final Function(
    TechnicianTableRow technician,
  ) onEdit;

  final Function(
    TechnicianTableRow technician,
  ) onDelete;

  const TechniciansTable({
    super.key,
    required this.technicians,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
      ),

      child: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Employee ID')),
          DataColumn(label: Text('Department')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],

        rows: technicians.map((tech) {
          return DataRow(
            cells: [

              DataCell(
                Text(tech.user.fullName),
              ),

              DataCell(
                Text(tech.user.email),
              ),

              DataCell(
                Text(
                  tech.technician.employeeId,
                ),
              ),

              DataCell(
                Text(
                  tech.technician.department,
                ),
              ),

              DataCell(
                Text(
                  tech.technician.status,
                ),
              ),

              DataCell(
                Row(
                  children: [

                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () =>
                          onEdit(tech),
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () =>
                          onDelete(tech),
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
