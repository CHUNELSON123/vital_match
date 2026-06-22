import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/constants/api_constants.dart';

import '../models/emergency_alert_model.dart';
import 'emergency_alert_remote_datasource.dart';

class EmergencyAlertRemoteDatasourceImpl
    implements EmergencyAlertRemoteDatasource {

  EmergencyAlertRemoteDatasourceImpl();

  @override
  Future<void> createEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/emergency-alerts',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        emergencyAlert.toMap(),
      ),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Failed to create emergency alert',
      );
    }
  }

  @override
  Future<EmergencyAlertModel>
      getEmergencyAlert(
    String alertId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/emergency-alerts/$alertId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Emergency alert not found',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return EmergencyAlertModel.fromMap(
      data['data'],
    );
  }

  @override
  Future<List<EmergencyAlertModel>>
      getAllEmergencyAlerts() async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/emergency-alerts',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load emergency alerts',
      );
    }

    final data =
        jsonDecode(
          response.body,
        );

    return (data['data'] as List)
        .map(
          (item) =>
              EmergencyAlertModel.fromMap(
            item,
          ),
        )
        .toList();
  }

  @override
  Future<void> updateEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/emergency-alerts/${emergencyAlert.alertId}',
      ),
      headers: {
        'Content-Type':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: jsonEncode(
        emergencyAlert.toMap(),
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update emergency alert',
      );
    }
  }

  @override
  Future<void> deleteEmergencyAlert(
    String alertId,
  ) async {

    final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

    final response =
        await http.delete(
      Uri.parse(
        '${ApiConstants.baseUrl}/emergency-alerts/$alertId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete emergency alert',
      );
    }
  }

  @override
  Future<List<EmergencyAlertModel>>
      getEmergencyAlertsByHospital(
    String hospitalId,
  ) async {

    final alerts =
        await getAllEmergencyAlerts();

    return alerts
        .where(
          (alert) =>
              alert.hospitalId ==
              hospitalId,
        )
        .toList();
  }
}