import 'package:flutter/material.dart';

class RegisterViewModel {

  String selectedRole = 'donor';
  double? latitude;
  double? longitude;

  String locationName = "Location not selected";
  // Step Management
  int currentStep = 1;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Form Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final weightController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // Form State
  String? selectedBloodGroup;

  bool locationAlertsEnabled = false;
  bool agreedToTerms = false;

  // Navigation
  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
    }
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    weightController.dispose();
    dateOfBirthController.dispose();
  }
}