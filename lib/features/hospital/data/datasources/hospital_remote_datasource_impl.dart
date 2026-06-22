import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:vital_match/core/constants/api_constants.dart';

import '../models/hospital_model.dart';
import 'hospital_remote_datasource.dart';

class HospitalRemoteDatasourceImpl
    implements HospitalRemoteDatasource {

  HospitalRemoteDatasourceImpl();

  @override
  Future<void> createHospital(
    HospitalModel hospital,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/hospitals',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        hospital.toMap(),
      ),
    );

    print(
      'CREATE HOSPITAL STATUS: ${response.statusCode}',
    );

    print(
      'CREATE HOSPITAL BODY: ${response.body}',
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Failed to create hospital',
      );
    }
  }

  @override
  Future<HospitalModel?> getHospitalByOwnerId(
    String ownerId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/hospitals/owner/$ownerId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode == 404) {
      return null;
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load hospital',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return HospitalModel.fromMap(
      data['data'],
    );
  }

  @override
  Future<HospitalModel> getHospital(
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
        '${ApiConstants.baseUrl}/hospitals/$hospitalId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Hospital not found',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return HospitalModel.fromMap(
      data['data'],
    );
  }

  @override
  Future<void> updateHospital(
    HospitalModel hospital,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/hospitals/${hospital.hospitalId}',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        hospital.toMap(),
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update hospital',
      );
    }
  }

  @override
  Future<void> deleteHospital(
    String hospitalId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.delete(
      Uri.parse(
        '${ApiConstants.baseUrl}/hospitals/$hospitalId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete hospital',
      );
    }
  }
}