import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:vital_match/core/constants/api_constants.dart';
import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource.dart';
import 'package:vital_match/features/donors/data/models/donor_model.dart';

class DonorRemoteDatasourceImpl implements DonorRemoteDatasource {
  DonorRemoteDatasourceImpl();

  Future<Map<String, String>> _authHeaders({
    bool includeContentType = false,
  }) async {
    final token =
        await FirebaseAuth.instance.currentUser!.getIdToken();

    return {
      if (includeContentType) 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<void> createDonorProfile(DonorModel donor) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/donors'),
      headers: await _authHeaders(
        includeContentType: true,
      ),
      body: jsonEncode(donor.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Failed to create donor profile: ${response.body}',
      );
    }
  }

  @override
  Future<DonorModel> getDonorProfile(String donorId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/donors/$donorId'),
      headers: await _authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Donor profile not found: ${response.body}',
      );
    }

    final data = jsonDecode(response.body);

    return DonorModel.fromJson(
      data['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> updateDonorProfile(DonorModel donor) async {
    final response = await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/donors/${donor.donorId}',
      ),
      headers: await _authHeaders(
        includeContentType: true,
      ),
      body: jsonEncode(donor.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update donor profile: ${response.body}',
      );
    }
  }

  @override
  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/donors/$donorId'),
      headers: await _authHeaders(
        includeContentType: true,
      ),
      body: jsonEncode({
        'isAvailable': isAvailable,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update donor availability: ${response.body}',
      );
    }
  }

  @override
  Future<List<DonorModel>> getAllDonors() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/donors'),
      headers: await _authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load donors: ${response.body}',
      );
    }

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map(
          (item) => DonorModel.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<DonorModel> getDonor(String donorId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/donors/$donorId'),
      headers: await _authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load donor: ${response.body}',
      );
    }

    final data = jsonDecode(response.body);

    return DonorModel.fromJson(
      data['data'] as Map<String, dynamic>,
    );
  }
}