import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vital_match/core/constants/api_constants.dart';
import '../models/lab_technician_model.dart';
import 'lab_technician_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';


class LabTechnicianRemoteDatasourceImpl
    implements
        LabTechnicianRemoteDatasource {

  LabTechnicianRemoteDatasourceImpl();


  final String
      labTechnicianCollection =
      'lab_technicians';



  @override
Future<void> createLabTechnician(
  LabTechnicianModel technician,
) async {

  final token =
    await FirebaseAuth
        .instance
        .currentUser!
        .getIdToken();

  final response =
      await http.post(
    Uri.parse(
      '${ApiConstants.baseUrl}/lab-technicians',
    ),
    headers: {
      'Content-Type':
          'application/json',

      'Authorization':
          'Bearer $token',
    },
    body: jsonEncode(
      technician.toMap(),
    ),
  );

  log(
  'CREATE TECH STATUS: ${response.statusCode}',
);

 log(
  'CREATE TECH BODY: ${response.body}',
);

if (response.statusCode != 201) {
  throw Exception(
    response.body,
  );
}
}



  @override
  Future<LabTechnicianModel>
      getLabTechnician(
    String technicianId,
  ) async {

     final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/lab-technicians/$technicianId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Technician not found',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return LabTechnicianModel.fromMap(
      data['data'],
    );
  }



  @override
  Future<List<LabTechnicianModel>>
      getAllLabTechnicians() async {

    final response =
    await http.get(
  Uri.parse(
    '${ApiConstants.baseUrl}/lab-technicians',
  ),
);

if (response.statusCode != 200) {
  throw Exception(
    'Failed to load technicians',
  );
}

final data =
    jsonDecode(
      response.body,
    );

return (data['data'] as List)
    .map(
      (item) =>
          LabTechnicianModel.fromMap(
        item,
      ),
    )
    .toList();
  }



  @override
  Future<void> updateLabTechnician(
    LabTechnicianModel technician,
  ) async {

    final token =
    await FirebaseAuth
        .instance
        .currentUser!
        .getIdToken();

print(
  'UPDATING TECHNICIAN ID: ${technician.technicianId}',
);

print(
  'UPDATE DATA: ${jsonEncode(technician.toMap())}',
);

final response =
    await http.put(
  Uri.parse(
    '${ApiConstants.baseUrl}/lab-technicians/${technician.technicianId}',
  ),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  },
  body: jsonEncode(
    technician.toMap(),
  ),
);

print(
  'UPDATE STATUS: ${response.statusCode}',
);

print(
  'UPDATE BODY: ${response.body}',
);
if (response.statusCode != 200) {
  throw Exception(
    'Failed to update technician',
  );
}
  }



  @override
  Future<void> deleteLabTechnician(
    String technicianId,
  ) async {
    final token =
    await FirebaseAuth
        .instance
        .currentUser!
        .getIdToken();

final response =
    await http.delete(
  Uri.parse(
    '${ApiConstants.baseUrl}/lab-technicians/$technicianId',
  ),
  headers: {
    'Authorization': 'Bearer $token',
  },
);
 
if (response.statusCode != 200) {
  throw Exception(
    'Failed to delete technician',
  );
}
  }

 @override
Future<List<LabTechnicianModel>>
    getLabTechniciansByHospital(
  String hospitalId,
) async {
  final token =
    await FirebaseAuth
        .instance
        .currentUser!
        .getIdToken();

final response =
    await http.get(
  Uri.parse(
    '${ApiConstants.baseUrl}/lab-technicians/hospital/$hospitalId',
  ),
  headers: {
    'Authorization':
        'Bearer $token',
  },
);

print(response.body);

if (response.statusCode != 200) {
  throw Exception(
    'Failed to load technicians',
  );
}

final data =
    jsonDecode(
      response.body,
    );

return (data['data'] as List)
    .map(
      (item) =>
          LabTechnicianModel.fromMap(
        item,
      ),
    )
    .toList();
}
}