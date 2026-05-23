import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource.dart';
import 'package:vital_match/features/donors/data/models/donor_model.dart';

class DonorRemoteDatasourceImpl implements DonorRemoteDatasource {
  final FirebaseFirestore firestore;

  DonorRemoteDatasourceImpl({required this.firestore});

  @override
  Future<void> createDonorProfile(DonorModel donor) async {
    await firestore.collection('donor').doc(donor.donorId).set(donor.toMap());
  }

  @override
  Future<DonorModel> getDonorProfile(String donorId) async {
    final doc = await firestore.collection('donor').doc(donorId).get();

    if (!doc.exists) {
      throw Exception('Donor profile not found');
    }
    return DonorModel.fromFirestore(doc);
  }

  @override
  Future<void> updateDonorProfile(DonorModel donor) async {
    await firestore
        .collection('donor')
        .doc(donor.donorId)
        .update(donor.toMap());
  }

  @override
  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  }) async {
    await firestore.collection('donors').doc(donorId).update({
      'isAvailable': isAvailable,
    });
  }
}
