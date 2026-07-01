import 'auth_remote_datasource.dart';
import '../models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vital_match/core/constants/api_constants.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
    String? bloodGroup,
    String? weight,
    String? dateOfBirth,
    double? latitude,
    double? longitude,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/register'),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'role': role,
        'bloodGroup': bloodGroup,
        'weight': weight,
        'dateOfBirth': dateOfBirth,
        'latitude': latitude,
        'longitude': longitude,
      }),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode != 201) {
      final data = jsonDecode(response.body);

      throw Exception(data['message'] ?? 'Registration failed');
    }
  }

 @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {

    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    print("API URL = ${ApiConstants.baseUrl}");

   
    final user = credential.user!;

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/auth/profile/${user.uid}',
      ),
    );

    print('PROFILE STATUS: ${response.statusCode}');
    print('PROFILE BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load user profile');
    }

    final data = jsonDecode(response.body);

    return AuthModel(
      uid: user.uid,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      role: data['role'] ?? '',
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AuthModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/auth/profile/${user.uid}',
      ),
    );

    print('PROFILE STATUS: ${response.statusCode}');
    print('PROFILE BODY: ${response.body}');

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    return AuthModel(
      uid: user.uid,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      role: data['role'] ?? '',
    );
  }
}
