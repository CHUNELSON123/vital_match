import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import '../viewmodels/donation_recording_viewmodel.dart';

class RecentDonationsTable
    extends StatelessWidget {

  const RecentDonationsTable({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final viewModel =
    context.watch<DonationRecordingViewModel>();

    final entries =
    viewModel.recentDonations;

    return Card(
      elevation: 0,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(
          24,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            const Text(
              'Recent Entries',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label:
                        Text('Donor'),
                  ),
                  DataColumn(
                    label: Text(
                      'Blood Type',
                    ),
                  ),
                  DataColumn(
                    label:
                        Text('Units'),
                  ),
                  DataColumn(
                    label: Text(
                      'Timestamp',
                    ),
                  ),
                  DataColumn(
                    label:
                        Text('Status'),
                  ),
                ],
                rows:
                    entries.map(
                  (entry) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            viewModel.getDonorName(
                              entry.donorId,
                            ),
                          )
                        ),

                        DataCell(
                          Text(
                            entry
                                .bloodGroup
                                .displayName,
                          ),
                        ),

                        DataCell(
                          Text(
                            entry
                                .bloodUnitsCollected
                                .toString(),
                          ),
                        ),

                        DataCell(
                          Text(
                            entry
                                .donationDate
                                .toString(),
                          ),
                        ),

                        DataCell(
                          Chip(
                            backgroundColor:
                                Colors.green
                                    .shade50,
                            label: Text(
                              entry
                                  .status
                                  .name,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}