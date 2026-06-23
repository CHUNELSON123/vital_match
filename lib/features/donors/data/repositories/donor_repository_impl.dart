import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource.dart';
import 'package:vital_match/features/donors/data/models/donor_model.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/donors/domain/repositories/donor_repository.dart';

class DonorRepositoryImpl implements DonorRepository {
  final DonorRemoteDatasource remoteDatasource;

  DonorRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> createDonorProfile(Donor donor) async {
    final donorModel = DonorModel(
      donorId: donor.donorId,
      userId: donor.userId,
      bloodGroup: donor.bloodGroup,
      weight: donor.weight,
      gpsLatitude: donor.gpsLatitude,
      gpsLongitude: donor.gpsLongitude,
      age: donor.age,
      pointsBalance: donor.pointsBalance,
      isAvailable: donor.isAvailable,
      isVerified: donor.isVerified,
      dateOfBirth: donor.dateOfBirth,
      createdAt: donor.createdAt,
      lastDonationDate: donor.lastDonationDate,
    );

    await remoteDatasource.createDonorProfile(donorModel);
  }

  @override
  Future<Donor> getDonorProfile(String donorId) async {
    return await remoteDatasource.getDonorProfile(donorId);
  }

  @override
  Future<void> updateDonorProfile(Donor donor) async {
    final donorModel = DonorModel(
      donorId: donor.donorId,
      userId: donor.userId,
      bloodGroup: donor.bloodGroup,
      weight: donor.weight,
      gpsLatitude: donor.gpsLatitude,
      gpsLongitude: donor.gpsLongitude,
      age: donor.age,
      pointsBalance: donor.pointsBalance,
      isAvailable: donor.isAvailable,
      isVerified: donor.isVerified,
      dateOfBirth: donor.dateOfBirth,
      createdAt: donor.createdAt,
      lastDonationDate: donor.lastDonationDate,
    );

    await remoteDatasource.updateDonorProfile(donorModel);
  }

  @override
  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  }) async {
    await remoteDatasource.updateAvailability(
      donorId: donorId,
      isAvailable: isAvailable,
    );
  }

  @override
Future<List<Donor>>
    getAllDonors() async {

  return await remoteDatasource
      .getAllDonors();
}

@override
Future<Donor> getDonor(
  String donorId,
) async {
  return await remoteDatasource
      .getDonor(
    donorId,
  );
}
}
