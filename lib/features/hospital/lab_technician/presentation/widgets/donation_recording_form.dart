import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/lab_technician/presentation/models/donor_dropdown_item.dart';
import 'package:provider/provider.dart';
import '../viewmodels/donation_recording_viewmodel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:vital_match/core/enums/donation_record_status.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';

class DonationRecordingForm extends StatelessWidget {
  const DonationRecordingForm({super.key});

  @override
  Widget build(BuildContext context) {

    final viewModel =
    context.watch<
        DonationRecordingViewModel>();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Color(0xFFFFEBEE),
                  child: Icon(
                    Icons.biotech,
                    color: Color(0xFFB71C1C),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Session Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: DropdownSearch<DonorDropdownItem>(
                    items: (filter, infiniteScrollProps) =>
                        viewModel.donors,

                    selectedItem: viewModel.selectedDonor,

                    compareFn: (
                      item,
                      selectedItem,
                    ) {
                      return item.donor.donorId ==
                          selectedItem.donor.donorId;
                    },


                    filterFn: (
                        donor,
                        filter,
                      ) {
                        final query =
                            filter.toLowerCase();

                        return donor.fullName
                                .toLowerCase()
                                .contains(query) ||
                            donor.phoneNumber
                                .toLowerCase()
                                .contains(query);
                      },

                    itemAsString: (donor) =>
                        '${donor.fullName} • '
                        '${donor.donor.bloodGroup.displayName} • '
                        '${donor.phoneNumber}',

                    onSelected: (selectedDonor) {
                      viewModel.selectDonor(selectedDonor);
                    },

                    decoratorProps: const DropDownDecoratorProps(
                      decoration: InputDecoration(
                        labelText: 'Select Donor',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    popupProps:
                        PopupProps.menu(
                      showSearchBox: true,

                      searchFieldProps:
                          const TextFieldProps(
                        decoration: InputDecoration(
                          hintText:
                              'Search by phone number or name...',
                          prefixIcon:
                              Icon(Icons.search),
                        ),
                      ),

                      itemBuilder: (
                        context,
                        donor,
                        isDisabled,
                        isSelected,
                      ) {
                         return ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            child: Text(
                              donor.donor.bloodGroup.displayName,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          title: Text(
                            donor.fullName,
                          ),
                          subtitle: Text(
                            donor.phoneNumber,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                 
                const SizedBox(width: 16),

                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: viewModel.bloodTypeController.text.isEmpty
                          ? null
                          : viewModel.bloodTypeController.text,
                      decoration: const InputDecoration(
                        labelText: 'Blood Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'A+',
                          child: Text('A+'),
                        ),
                        DropdownMenuItem(
                          value: 'A-',
                          child: Text('A-'),
                        ),
                        DropdownMenuItem(
                          value: 'B+',
                          child: Text('B+'),
                        ),
                        DropdownMenuItem(
                          value: 'B-',
                          child: Text('B-'),
                        ),
                        DropdownMenuItem(
                          value: 'AB+',
                          child: Text('AB+'),
                        ),
                        DropdownMenuItem(
                          value: 'AB-',
                          child: Text('AB-'),
                        ),
                        DropdownMenuItem(
                          value: 'O+',
                          child: Text('O+'),
                        ),
                        DropdownMenuItem(
                          value: 'O-',
                          child: Text('O-'),
                        ),
                      ],
                     onChanged: (value) {
                      if (value != null) {
                        viewModel.bloodTypeController.text =
                            value;

                        viewModel.refreshPreview();
                      }
                    },
                    ),
                  ),

              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller:
                        viewModel.donorWeightController,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) {
                      viewModel.refreshPreview();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Donor Weight (kg)',
                      hintText: '60',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller:
                        viewModel.unitsCollectedController,

                    keyboardType:
                        TextInputType.number,

                    onChanged: (_) {
                      viewModel.refreshPreview();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Units Collected',
                      hintText: '1 unit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller:
                        viewModel.collectionDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Collection Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    onTap: () async {
                      final picked =
                          await showDatePicker(
                        context: context,
                        firstDate:
                            DateTime(2020),
                        lastDate:
                            DateTime.now(),
                        initialDate:
                            DateTime.now(),
                      );

                      if (picked != null) {
                        viewModel
                            .collectionDateController
                            .text =
                            picked
                                .toIso8601String();
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
                  viewModel.notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Session Notes',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                onPressed: () async {
                  print('BUTTON PRESSED');

                  if (!viewModel.donorVerified ||
                      !viewModel.screeningCompleted ||
                      !viewModel.bagLabeled ||
                      !viewModel.temperatureRecorded) {

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Complete all compliance checks first',
                        ),
                      ),
                    );

                    return;
                  }

                  final donor =
                      viewModel.selectedDonor;

                  if (donor == null) {
                    return;
                  }

                  final currentUser =
                      FirebaseAuth
                          .instance
                          .currentUser;

                  if (currentUser == null) {
                    return;
                  }

                 final technician =
                          viewModel.currentTechnician;

                      print(
                        'CURRENT TECHNICIAN: $technician',
                      );

                      if (technician == null) {

                        print(
                          'TECHNICIAN IS NULL',
                        );

                        return;
                      }

                  final units = int.tryParse(
                    viewModel.unitsCollectedController.text.trim(),
                  );

                  if (units == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Units collected is required',
                        ),
                      ),
                    );
                    return;
                  }

                  final donorWeight =
                      double.tryParse(
                    viewModel
                        .donorWeightController
                        .text
                        .trim(),
                  );

                  if (donorWeight == null ||
                      donorWeight < 50) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Donor weight must be at least 50 kg',
                        ),
                      ),
                    );
                    return;
                  }

                  final donationDate =
                      DateTime.tryParse(
                    viewModel
                        .collectionDateController
                        .text,
                  );

                  if (donationDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Collection date is required',
                        ),
                      ),
                    );
                    return;
                  }

                  if (units < 1 || units > 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'A donation can only be 1 or 2 units',
                        ),
                      ),
                    );
                    return;
                  }

                  final donationRecord =
                      DonationRecord(
                    recordId:
                        const Uuid().v4(),

                    donorId:
                        donor.donor.donorId,

                   hospitalId:
                      technician.hospitalId,

                    technicianId:
                      technician.technicianId,

                    donationDate:
                        donationDate,

                    bloodUnitsCollected:
                        units,

                    pointsAwarded: 10,

                    bloodGroup:
                        viewModel
                            .stringToBloodType(
                      viewModel
                          .bloodTypeController
                          .text,
                    ),

                    donorWeight:
                        donorWeight,

                    status:
                        DonationRecordStatus
                            .pending,
                  );

                  await viewModel.recordDonation(
                    donationRecord,
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Record Donation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
