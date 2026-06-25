import 'package:flutter/material.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donation_record/domain/usecases/create_donation_record_usecase.dart';
import '../../../lab_technician/domain/usecases/get_dashboard_donation_records_usecase.dart';
import 'package:vital_match/features/donors/domain/usecases/get_all_donors_usecase.dart';
import 'package:vital_match/features/users/domain/usecase/get_all_user_usecase.dart';
import '../models/donor_dropdown_item.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/donors/domain/usecases/update_donor_profile_usecase.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:uuid/uuid.dart';
import 'package:vital_match/features/blood_unit/domain/entities/blood_unit.dart';
import '../../../../blood_unit/domain/usecases/create_blood_unit_uscase.dart';
import 'package:vital_match/core/enums/storage_status.dart';
import '../../../lab_technician/domain/usecases/get_dashboard_blood_units_usecase.dart';

class DonationRecordingViewModel
    extends ChangeNotifier {

  final CreateDonationRecordUsecase
      createDonationRecordUsecase;

  final GetDashboardDonationRecordsUsecase
      getDonationRecordsUsecase;

  final GetAllDonorsUsecase
    getAllDonorsUsecase;

  final GetAllUserUsecase
    getAllUsersUsecase;

  final UpdateDonorProfileUsecase
    updateDonorProfileUsecase;

  final CreateBloodUnitUsecase
    createBloodUnitUsecase;

  final GetDashboardBloodUnitsUsecase
    getDashboardBloodUnitsUsecase;

 DonationRecordingViewModel({
  required this.createDonationRecordUsecase,
  required this.getDonationRecordsUsecase,
  required this.getAllDonorsUsecase,
  required this.getAllUsersUsecase,
  required this.updateDonorProfileUsecase,
  required this.createBloodUnitUsecase,
  required this.getDashboardBloodUnitsUsecase,
});

  bool isLoading = false;

  List<DonationRecord>
      recentDonations = [];

  List<BloodUnit> bloodUnits = [];

  List<DonorDropdownItem> donors = [];

  LabTechnician? currentTechnician;

  final bloodTypeController =
    TextEditingController();

  final donorWeightController =
      TextEditingController();

  final unitsCollectedController =
    TextEditingController();

  final collectionDateController =
      TextEditingController();

  final notesController =
      TextEditingController();

  Future<void> loadCurrentTechnician() async {

  final uid =
      FirebaseAuth
          .instance
          .currentUser!
          .uid;
  
  print('CURRENT USER UID: $uid');

  currentTechnician =
      await ServiceLocator
          .getLabTechnicianByUserIdUsecase(
    uid,
  );

  print(
    'LOADED TECHNICIAN: $currentTechnician',
  );

  notifyListeners();
}

  Future<void> loadRecentDonations()
async {

  print('LOADING RECENT DONATIONS');

  isLoading = true;

  notifyListeners();

  try {

    recentDonations =
        await getDonationRecordsUsecase();

    print(
      'DONATIONS LOADED: ${recentDonations.length}',
    );

    recentDonations.sort(
      (a, b) =>
          b.donationDate.compareTo(
        a.donationDate,
      ),
    );

  } catch (e, stack) {

    print(
      'LOAD RECENT DONATIONS FAILED',
    );

    print(e);
    print(stack);

  } finally {

    isLoading = false;

    notifyListeners();
  }
}

Future<void> loadInventory() async {

  print('LOADING INVENTORY');

  bloodUnits =
      await getDashboardBloodUnitsUsecase();

  print(
    'INVENTORY COUNT: ${bloodUnits.length}',
  );

  for (final unit in bloodUnits) {

    print(
      'INVENTORY UNIT -> '
      '${unit.bloodType} : ${unit.quantity}',
    );
  }

  notifyListeners();
}

  Future<void> recordDonation(
  DonationRecord donationRecord,
) async {

  isLoading = true;

  notifyListeners();

  try {

    if (selectedDonor != null) {

      final donor =
          selectedDonor!.donor;

      final updatedBloodType =
          stringToBloodType(
        bloodTypeController.text,
      );

      final updatedWeight =
          double.tryParse(
            donorWeightController.text.trim(),
          ) ??
          donor.weight;

      if (updatedBloodType !=
              donor.bloodGroup ||
          updatedWeight != donor.weight) {

        final updatedDonor =
            Donor(
          donorId: donor.donorId,
          userId: donor.userId,
          bloodGroup:
              updatedBloodType,
          weight: updatedWeight,
          gpsLatitude:
              donor.gpsLatitude,
          gpsLongitude:
              donor.gpsLongitude,
          age: donor.age,
          pointsBalance:
              donor.pointsBalance,
          isAvailable:
              donor.isAvailable,
          isVerified:
              donor.isVerified,
          dateOfBirth:
              donor.dateOfBirth,
          createdAt:
              donor.createdAt,
          lastDonationDate:
              donor.lastDonationDate,
        );

        print('UPDATING DONOR DONATION DETAILS');

await updateDonorProfileUsecase(
  updatedDonor,
);

print('DONOR UPDATE COMPLETED');

        selectedDonor = DonorDropdownItem(
          donor: updatedDonor,
          fullName: selectedDonor!.fullName,
          phoneNumber: selectedDonor!.phoneNumber,
        );
      }
    }

    print('CREATING DONATION');

await createDonationRecordUsecase(
  donationRecord,
);

final bloodUnit = BloodUnit(
  bloodUnitId: const Uuid().v4(),

  recordId: donationRecord.recordId,

  hospitalId: donationRecord.hospitalId,

  bloodBankId: null,

  bloodType: donationRecord.bloodGroup,

  componentType: 'Whole Blood',

  quantity: donationRecord.bloodUnitsCollected,

  collectionDate: donationRecord.donationDate,

  expiryDate: donationRecord.donationDate.add(
    const Duration(days: 42),
  ),

  storageStatus: StorageStatus.available,
);

await createBloodUnitUsecase(
  bloodUnit,
);

print('DONATION CREATED');

await loadRecentDonations();
await loadInventory();

selectedDonor = null;

bloodTypeController.clear();

donorWeightController.clear();

unitsCollectedController.clear();

collectionDateController.clear();

notesController.clear();

print(
  'RECENT DONATIONS RELOADED',
);

  } finally {

    isLoading = false;

    notifyListeners();
  }
}
  Future<void> loadDonors() async {

  print('LOAD DONORS STARTED');

  final donorProfiles =
      await getAllDonorsUsecase();

  print('DONORS RECEIVED: ${donorProfiles.length}');

  final users =
      await getAllUsersUsecase();

  print('USERS RECEIVED: ${users.length}');

  donors =
      donorProfiles.map((donor) {

    final matches =
    users.where(
  (user) =>
      user.userId ==
      donor.userId,
).toList();

if (matches.isEmpty) {
  print(
    'NO USER FOUND FOR DONOR: ${donor.userId}',
  );

  return DonorDropdownItem(
    donor: donor,
    fullName: 'Unknown User',
    phoneNumber: 'No phone number'
  );
}

final user = matches.first;

    return DonorDropdownItem(
      donor: donor,
      fullName: user.fullName,
      phoneNumber: user.phoneNumber,
    );

  }).toList();

  print('DROPDOWN ITEMS: ${donors.length}');

  notifyListeners();
}

DonorDropdownItem? selectedDonor;

bool donorVerified = false;

bool screeningCompleted = false;

bool bagLabeled = false;

bool temperatureRecorded = false;

void refreshPreview() {
  notifyListeners();
}

void toggleDonorVerified(
  bool value,
) {
  donorVerified = value;
  notifyListeners();
}

void toggleScreeningCompleted(
  bool value,
) {
  screeningCompleted = value;
  notifyListeners();
}

void toggleBagLabeled(
  bool value,
) {
  bagLabeled = value;
  notifyListeners();
}

void toggleTemperatureRecorded(
  bool value,
) {
  temperatureRecorded = value;
  notifyListeners();
}

void selectDonor(
  DonorDropdownItem? donor,
) {
  selectedDonor = donor;

  if (donor != null) {
    bloodTypeController.text =
        _bloodTypeToString(
      donor.donor.bloodGroup,
    );

    donorWeightController.text =
        donor.donor.weight.toStringAsFixed(1);

    print(
  'Selected blood type: ${bloodTypeController.text}',
);
  }

  notifyListeners();
}

BloodType stringToBloodType(
  String value,
) {
  switch (value.trim()) {
    case 'A+':
      return BloodType.aPositive;

    case 'A-':
      return BloodType.aNegative;

    case 'B+':
      return BloodType.bPositive;

    case 'B-':
      return BloodType.bNegative;

    case 'AB+':
      return BloodType.abPositive;

    case 'AB-':
      return BloodType.abNegative;

    case 'O-':
      return BloodType.oNegative;

    default:
      return BloodType.oPositive;
  }
}

String getDonorName(
  String donorId,
) {
  try {
    return donors.firstWhere(
      (d) => d.donor.donorId == donorId,
    ).fullName;
  } catch (_) {
    return donorId;
  }
}

int getCurrentInventoryForBloodType(
  BloodType bloodType,
) {
  print(
  'LOOKING FOR: $bloodType',
);

for (final unit in bloodUnits) {
  print(
    'UNIT TYPE: ${unit.bloodType}',
  );
}
  return bloodUnits
      .where(
        (unit) =>
            unit.bloodType == bloodType,
      )
      .fold(
        0,
        (total, unit) =>
            total + unit.quantity,
      );
}

String _bloodTypeToString(
  BloodType bloodType,
) {
  switch (bloodType) {
    case BloodType.aPositive:
      return 'A+';

    case BloodType.aNegative:
      return 'A-';

    case BloodType.bPositive:
      return 'B+';

    case BloodType.bNegative:
      return 'B-';

    case BloodType.abPositive:
      return 'AB+';

    case BloodType.abNegative:
      return 'AB-';

    case BloodType.oPositive:
      return 'O+';

    case BloodType.oNegative:
      return 'O-';
  }
}

@override
void dispose() {
  bloodTypeController.dispose();
  donorWeightController.dispose();
  unitsCollectedController.dispose();
  collectionDateController.dispose();
  notesController.dispose();
  super.dispose();
}
}
