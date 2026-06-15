import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource.dart';
import 'package:vital_match/features/donors/data/models/donor_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vital_match/core/constants/api_constants.dart';

class DonorRemoteDatasourceImpl implements DonorRemoteDatasource {
  DonorRemoteDatasourceImpl();

  @override
  Future<void> createDonorProfile(DonorModel donor) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/donors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(donor.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create donor profile');
    }
  }

  @override
  Future<DonorModel> getDonorProfile(String donorId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/donors/$donorId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Donor profile not found');
    }

    final data = jsonDecode(response.body);

    return DonorModel.fromMap(data['data']);
  }

  @override
  Future<void> updateDonorProfile(DonorModel donor) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/donors/${donor.donorId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(donor.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update donor profile');
    }
  }

  @override
  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/donors/$donorId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isAvailable': isAvailable}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update donor availability');
    }
  }
}
