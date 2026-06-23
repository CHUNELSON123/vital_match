import 'package:flutter/material.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donation_record/domain/usecases/get_pending_donation_records_usecase.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/donors/domain/usecases/get_donor_usecase.dart';

class DonationVerificationViewModel
    extends ChangeNotifier {

  final GetPendingDonationRecordsUsecase
    getPendingDonationRecordsUsecase;

  final GetDonorUsecase
      getDonorUsecase;

  DonationVerificationViewModel({
    required this
        .getPendingDonationRecordsUsecase,

    required this.getDonorUsecase,
  });

  bool isLoading = false;

  List<DonationRecord>
      pendingDonations = [];

  DonationRecord? selectedDonation;
  Donor? donor;

  Future<void> loadPendingDonations()
  async {

    isLoading = true;

    notifyListeners();

    try {

      pendingDonations =
          await getPendingDonationRecordsUsecase();

      if (pendingDonations.isNotEmpty) {

        selectedDonation =
            pendingDonations.first;

        await loadDonor();
      }

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> loadDonor()
    async {

      if (selectedDonation == null) {
        return;
      }

      donor =
          await getDonorUsecase(
        selectedDonation!.donorId,
      );

      notifyListeners();
    }

  Future<void> selectDonation(
  DonationRecord donation,
) async {

  selectedDonation =
      donation;

  await loadDonor();

  notifyListeners();
}
}