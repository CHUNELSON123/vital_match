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
  return AppUserModel.fromMap(
    doc.data()!,
    userId: doc.id,
  );
}

factory AppUserModel.fromMap(
  Map<String, dynamic> data, {
  String? userId,
}) {

  DateTime createdAt;

  if (data['createdAt'] is Timestamp) {
    createdAt =
        (data['createdAt'] as Timestamp)
            .toDate();
  } else {
    createdAt =
        DateTime.parse(
          data['createdAt'],
        );
  }

  return AppUserModel(
    userId: userId ?? data['userId'] ?? '',
    fullName: data['fullName'] ?? '',
    email: data['email'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    
    role: UserRole.values.firstWhere(
      (role) => role.name == data['role'],
       orElse: () {
    print(
      'UNKNOWN ROLE: ${data['role']}',
    );

    return UserRole.values.first;
  },
    ),
    createdAt: createdAt,
  );
}
}
