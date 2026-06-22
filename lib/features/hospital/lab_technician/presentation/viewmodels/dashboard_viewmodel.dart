import 'package:flutter/material.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import 'package:vital_match/features/blood_unit/domain/entities/blood_unit.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';
 
import '../../domain/usecases/get_dashboard_blood_units_usecase.dart';
import '../../domain/usecases/get_dashboard_donation_records_usecase.dart';
import '../../domain/usecases/get_dashboard_emergency_alerts_usecase.dart';
 

class DashboardActivity {

  final String title;

  final String subtitle;

  final DateTime timestamp;

  const DashboardActivity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}

class DashboardViewModel
    extends ChangeNotifier {

  List<DashboardActivity> activities = [];

  final GetDashboardBloodUnitsUsecase
      getDashboardBloodUnitsUsecase;

  final GetDashboardDonationRecordsUsecase
      getDashboardDonationRecordsUsecase;

  final GetDashboardEmergencyAlertsUsecase
      getDashboardEmergencyAlertsUsecase;

 
  DashboardViewModel({
    required this.getDashboardBloodUnitsUsecase,
    required this.getDashboardDonationRecordsUsecase,
    required this.getDashboardEmergencyAlertsUsecase,
 
  });

  bool isLoading = false;

  List<BloodUnit> bloodUnits = [];

  List<DonationRecord>
      donationRecords = [];

  List<EmergencyAlert>
      emergencyAlerts = [];

 

  Future<void> loadDashboard() async {

  isLoading = true;

  notifyListeners();

  try {

    bloodUnits =
        await getDashboardBloodUnitsUsecase();

    print(
  'DASHBOARD BLOOD UNITS: ${bloodUnits.length}',
);

    donationRecords =
        await getDashboardDonationRecordsUsecase();
    
    print(
  'DASHBOARD DONATION RECORDS: ${donationRecords.length}',
);

    emergencyAlerts =
        await getDashboardEmergencyAlertsUsecase();

   donationRecords =
    await getDashboardDonationRecordsUsecase();

print(
  'DASHBOARD DONATION COUNT: ${donationRecords.length}',
);


    activities = [

      ...donationRecords.map(
        (record) => DashboardActivity(
          title:
              'Donation Recorded',
          subtitle:
              '${record.bloodGroup.displayName} • ${record.bloodUnitsCollected} unit(s)',
          timestamp:
              record.donationDate,
        ),
      ),

      ...emergencyAlerts.map(
        (alert) => DashboardActivity(
          title:
              'Emergency Alert Created',
          subtitle:
              alert.bloodGroup.displayName,
          timestamp:
              alert.createdAt,
        ),
      ),

      ...bloodUnits.map(
        (unit) => DashboardActivity(
          title:
              'Blood Unit Added',
          subtitle:
              '${unit.bloodType.displayName} • ${unit.quantity} unit(s)',
          timestamp:
              unit.collectionDate,
        ),
      ),

       
    ];

    activities.sort(
      (a, b) =>
          b.timestamp.compareTo(
        a.timestamp,
      ),
    );

    activities =
        activities.take(10).toList();

  } finally {

    isLoading = false;

    notifyListeners();
  }
}

  int get totalAvailableUnits {

    int total = 0;

    for (final unit in bloodUnits) {

      total += unit.quantity;
    }

    return total;
  }

  int get totalDonationRecords {

    return donationRecords.length;
  }

  int get totalEmergencyAlerts {

    return emergencyAlerts.length;
  }


  List<DonationRecord>
      get recentDonationRecords {

    final records =
        List<DonationRecord>.from(
      donationRecords,
    );

    records.sort(
      (a, b) =>
          b.donationDate.compareTo(
        a.donationDate,
      ),
    );

    return records.take(10).toList();
  }
}