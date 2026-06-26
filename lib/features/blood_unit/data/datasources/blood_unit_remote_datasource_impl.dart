import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/constants/api_constants.dart';

import '../models/blood_unit_model.dart';
import 'blood_unit_remote_datasource.dart';

class BloodUnitRemoteDatasourceImpl
    implements BloodUnitRemoteDatasource {

  BloodUnitRemoteDatasourceImpl();

  @override
  Future<void> createBloodUnit(
    BloodUnitModel bloodUnit,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/blood-units',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        bloodUnit.toMap(),
      ),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Failed to create blood unit',
      );
    }
  }

  @override
  Future<BloodUnitModel> getBloodUnit(
    String bloodUnitId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/blood-units/$bloodUnitId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Blood unit not found',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return BloodUnitModel.fromMap(
      data['data'],
    );
  }

  @override
  Future<List<BloodUnitModel>>
      getAllBloodUnits() async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/blood-units',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load blood units',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return (data['data'] as List)
    .where(
      (item) =>
          item is Map<String, dynamic> &&
          (item.containsKey('bloodType') ||
              item.containsKey('bloodGroup')),
    )
    .map(
      (item) =>
          BloodUnitModel.fromMap(item),
    )
    .toList();
  }

  @override
  Future<void> updateBloodUnit(
    BloodUnitModel bloodUnit,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final updatePayload =
        bloodUnit.toMap()
          ..['updatedBy'] =
              FirebaseAuth
                  .instance
                  .currentUser!
                  .uid;

    final response =
        await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/blood-units/${bloodUnit.bloodUnitId}',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(updatePayload),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update blood unit',
      );
    }
  }

  @override
  Future<void> deleteBloodUnit(
    String bloodUnitId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.delete(
      Uri.parse(
        '${ApiConstants.baseUrl}/blood-units/$bloodUnitId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete blood unit',
      );
    }
  }

  @override
  Future<List<BloodUnitModel>>
      getBloodUnitsByHospital(
    String hospitalId,
  ) async {

    final units =
        await getAllBloodUnits();

    return units
        .where(
          (unit) =>
              unit.hospitalId ==
              hospitalId,
        )
        .toList();
  }
}
