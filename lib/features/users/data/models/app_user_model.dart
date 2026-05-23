import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/user_role.dart';
import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  
  const AppUserModel({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.createdAt,
  });

//Convert Model To Map

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName, 
      'email': email,
      'phoneNumber': phoneNumber, 
      'role': role.name,
      'createdAt': createdAt,
    };
  }

//Create Model From Firestore

  factory AppUserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AppUserModel(
      userId: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      role: UserRole.values.firstWhere((role) => role.name == data['role'],),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
