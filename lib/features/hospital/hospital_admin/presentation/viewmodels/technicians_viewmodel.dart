import 'package:vital_match/core/di/service_locator.dart';
import '../../data/models/technician_table_row.dart';
import 'package:vital_match/features/users/domain/entities/app_user.dart';

class TechniciansViewModel {

 Future<List<TechnicianTableRow>>
getTechniciansByHospital(
  String hospitalId,
) async {

  final technicians =
      await ServiceLocator
          .getLabTechniciansByHospitalUsecase(
    hospitalId,
  );

  print(
    'TECHNICIANS COUNT: ${technicians.length}',
  );


  List<TechnicianTableRow> rows = [];

  for (final technician in technicians) {

     print(
      'TECH USER ID: ${technician.userId}',
    );


     try {

  final AppUser? user =
      await ServiceLocator
          .getUserByIdUsecase(
    technician.userId,
  );

  print(
    'USER FOUND: ${user?.fullName}',
  );

  if (user != null) {

    rows.add(
      TechnicianTableRow(
        user: user,
        technician: technician,
      ),
    );
  }

} catch (e) {

  print(
    'USER ERROR: $e',
  );
}

      

    
  }

   print(
    'ROWS COUNT: ${rows.length}',
  );


  return rows;
}
}