import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vital_match/features/blood_unit/domain/entities/blood_unit.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import '../viewmodels/dashboard_viewmodel.dart';

class InventoryOverviewTable
    extends StatelessWidget {

  const InventoryOverviewTable({
    super.key,
  });

  List<Map<String, String>>
      _buildInventory(
    List<BloodUnit> bloodUnits,
  ) {
    final Map<String, int> totals = {};

    for (final unit in bloodUnits) {
      final key =
          unit.bloodType.displayName;

      totals[key] =
          (totals[key] ?? 0) +
              unit.quantity;
    }

    return totals.entries.map(
      (entry) {
        String status =
            'Healthy';

        if (entry.value < 20) {
          status = 'Critical';
        } else if (entry.value < 50) {
          status = 'Low';
        }

        return {
          'group': entry.key,
          'units':
              entry.value.toString(),
          'reserved': '0',
          'status': status,
        };
      },
    ).toList();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final dashboard =
        context.watch<
            DashboardViewModel>();

    final inventory =
        _buildInventory(
      dashboard.bloodUnits,
    );

    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [
          const Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              Text(
                'Inventory Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Text(
                'Export Report',
                style: TextStyle(
                  color: Color(
                    0xFF005FAF,
                  ),
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'Blood Type',
                ),
              ),
              DataColumn(
                label: Text(
                  'Units',
                ),
              ),
              DataColumn(
                label: Text(
                  'Reserved',
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                ),
              ),
            ],
            rows:
                inventory.map(
              (item) {
                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal:
                              12,
                          vertical:
                              6,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFF005FAF,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          item[
                              'group']!,
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item[
                            'units']!,
                      ),
                    ),
                    DataCell(
                      Text(
                        item[
                            'reserved']!,
                      ),
                    ),
                    DataCell(
                      _statusChip(
                        item[
                            'status']!,
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(
    String status,
  ) {
    Color color;

    switch (status) {
      case 'Healthy':
        color =
            Colors.green;
        break;

      case 'Low':
        color =
            Colors.orange;
        break;

      default:
        color =
            Colors.red;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration:
          BoxDecoration(
        color: color.withValues(
          alpha: 0.1,
        ),
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}