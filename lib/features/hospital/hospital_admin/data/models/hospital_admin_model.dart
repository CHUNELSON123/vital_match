import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/hospital_admin.dart';


class HospitalAdminModel
    extends HospitalAdmin {

  const HospitalAdminModel({
    required super.adminId,
    required super.userId,
    required super.hospitalId,
    required super.adminLevel,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hospitalId': hospitalId,
      'adminLevel': adminLevel,
    };
  }


  factory HospitalAdminModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return HospitalAdminModel(
      adminId: doc.id,

      userId:
          data['userId'] ?? '',

      hospitalId:
          data['hospitalId'] ?? '',

      adminLevel:
          data['adminLevel'] ?? '',
    );
  }
}