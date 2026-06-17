import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../models/reports_summary_model.dart';

import 'reports_remote_datasource.dart';

class ReportsRemoteDatasourceImpl
    implements
        ReportsRemoteDatasource {

  final String baseUrl =
      'http://localhost:3000';

  @override
  Future<ReportsSummaryModel>
      getHospitalReports(
    String hospitalId,
  ) async {

    final response =
        await http.get(
      Uri.parse(
        '$baseUrl/api/reports/hospital/$hospitalId',
      ),
    );

    if (response.statusCode == 200) {

      return ReportsSummaryModel
          .fromJson(
        jsonDecode(
          response.body,
        ),
      );
    }

    throw Exception(
      'Failed to load reports',
    );
  }
}