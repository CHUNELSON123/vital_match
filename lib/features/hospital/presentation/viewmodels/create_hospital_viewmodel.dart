import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:geolocator/geolocator.dart';

class CreateHospitalViewModel {
  final createHospitalUsecase = ServiceLocator.createHospitalUsecase;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final contactController = TextEditingController();

  final geofenceRadiusController = TextEditingController(text: '10');

  Future<void> createHospital() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission denied',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final hospital = Hospital(
      hospitalId: '',
      ownerId: uid,
      name: nameController.text.trim(),
      address: addressController.text.trim(),
      contactNumber: contactController.text.trim(),
      latitude: position.latitude,
      longitude: position.longitude,
      geofenceRadiusKm: int.parse(
        geofenceRadiusController.text.trim(),
      ),
    );

    await createHospitalUsecase(
      hospital,
    );
  }

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    contactController.dispose();
    geofenceRadiusController.dispose();
  }
}
