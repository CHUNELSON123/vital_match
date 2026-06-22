import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/constants/api_constants.dart';

import '../models/donation_record_model.dart';
import 'donation_record_remote_datasource.dart';

class DonationRecordRemoteDatasourceImpl
    implements DonationRecordRemoteDatasource {

  DonationRecordRemoteDatasourceImpl();

  @override
  Future<void> createDonationRecord(
    DonationRecordModel donationRecord,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    
    print(jsonEncode(donationRecord.toMap()));
    
    final response =
        await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/donation-records',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        donationRecord.toMap(),
      ),
    );

    if (response.statusCode != 201) {
       print('CREATE DONATION RECORD FAILED');
        print('STATUS CODE: ${response.statusCode}');
        print('BODY: ${response.body}');
            throw Exception(
        'Failed to create donation record',
      );
    }
  }

  @override
  Future<DonationRecordModel>
      getDonationRecord(
    String recordId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/donation-records/$recordId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Donation record not found',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return DonationRecordModel.fromMap(
      data['data'],
    );
  }

  @override
  Future<List<DonationRecordModel>>
      getAllDonationRecords() async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/donation-records',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load donation records',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return (data['data'] as List)
        .map(
          (item) =>
              DonationRecordModel.fromMap(
            item,
          ),
        )
        .toList();
  }

  @override
  Future<void> updateDonationRecord(
    DonationRecordModel donationRecord,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/donation-records/${donationRecord.recordId}',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        donationRecord.toMap(),
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update donation record',
      );
    }
  }

  @override
  Future<void> deleteDonationRecord(
    String recordId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.delete(
      Uri.parse(
        '${ApiConstants.baseUrl}/donation-records/$recordId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete donation record',
      );
    }
  }

  @override
  Future<List<DonationRecordModel>>
      getDonationRecordsByHospital(
    String hospitalId,
  ) async {

    final records =
        await getAllDonationRecords();

    return records
        .where(
          (record) =>
              record.hospitalId ==
              hospitalId,
        )
        .toList();
  }
}