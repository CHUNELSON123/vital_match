import '../models/audit_trail_model.dart';
import 'audit_trail_remote_datasource.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/constants/api_constants.dart';

class AuditTrailRemoteDatasourceImpl
    implements
        AuditTrailRemoteDatasource {
    
    AuditTrailRemoteDatasourceImpl();

  final String auditTrailCollection =
      'audit_trails';

  @override
Future<void> createAuditTrail(
  AuditTrailModel auditTrail,
) async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.post(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails',
    ),
    headers: {
      'Content-Type':
          'application/json',
      'Authorization':
          'Bearer $token',
    },
    body: jsonEncode(
      auditTrail.toMap(),
    ),
  );

  print(
  'AUDIT STATUS: ${response.statusCode}',
);

print(
  'AUDIT BODY: ${response.body}',
);

  if (response.statusCode != 201) {
    throw Exception(
      'Failed to create audit trail',
    );
  }
}


  @override
Future<AuditTrailModel>
    getAuditTrail(
  String auditId,
) async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.get(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails/$auditId',
    ),
    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Audit trail not found',
    );
  }

  final data =
      jsonDecode(
        response.body,
      );

  return AuditTrailModel.fromMap(
    data['data'],
  );
}

@override
Future<List<AuditTrailModel>>
    getAllAuditTrails() async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.get(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails',
    ),
    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load audit trails',
    );
  }

  final data =
      jsonDecode(
        response.body,
      );

  return (data['data'] as List)
      .map(
        (item) =>
            AuditTrailModel.fromMap(
          item,
        ),
      )
      .toList();
}

@override
Future<List<AuditTrailModel>>
    getAuditTrailsByUser(
  String userId,
) async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.get(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails/user/$userId',
    ),
    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load audit trails',
    );
  }

  final data =
      jsonDecode(
        response.body,
      );

  return (data['data'] as List)
      .map(
        (item) =>
            AuditTrailModel.fromMap(
          item,
        ),
      )
      .toList();
}


@override
Future<void> updateAuditTrail(
  AuditTrailModel auditTrail,
) async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.put(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails/${auditTrail.auditId}',
    ),
    headers: {
      'Content-Type':
          'application/json',
      'Authorization':
          'Bearer $token',
    },
    body: jsonEncode(
      auditTrail.toMap(),
    ),
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to update audit trail',
    );
  }
}

@override
Future<void> deleteAuditTrail(
  String auditId,
) async {

  final token =
      await FirebaseAuth
          .instance
          .currentUser!
          .getIdToken();

  final response =
      await http.delete(
    Uri.parse(
      '${ApiConstants.baseUrl}/audit-trails/$auditId',
    ),
    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to delete audit trail',
    );
  }
}

@override
Future<List<AuditTrailModel>>
    getAuditTrailsByHospital(
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
      '${ApiConstants.baseUrl}/audit-trails/hospital/$hospitalId',
    ),
    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load audit trails',
    );
  }

  final data =
      jsonDecode(
        response.body,
      );

  return (data['data'] as List)
      .map(
        (item) =>
            AuditTrailModel.fromMap(
          item,
        ),
      )
      .toList();
}
}