import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../viewmodels/register_view_model.dart';
import '../../domain/usecases/register_usecase.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;

  bool get canShowMap {
    return kIsWeb ||
        Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS;
  }

  final RegisterUsecase registerUsecase =
    ServiceLocator.registerUsecase;

  final vm = RegisterViewModel();
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  final List<String> roles = [
  'donor',
  'hospital_admin',
  'blood_bank_manager',
];

  Future<void> _registerUser() async {
  try {

    await registerUsecase(
      fullName: vm.fullNameController.text.trim(),
      email: vm.emailController.text.trim(),
      password: vm.passwordController.text.trim(),
      phoneNumber: vm.phoneController.text.trim(),
      role: vm.selectedRole,
      bloodGroup: vm.selectedBloodGroup,
      weight: vm.weightController.text.trim(),
      dateOfBirth: vm.dateOfBirthController.text.trim(),
      latitude: vm.latitude,
      longitude: vm.longitude,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Registration successful',
        ),
      ),
    );

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const LoginPage(),
  ),
);

  } catch (e, stackTrace) {

      debugPrint(
        'REGISTER ERROR: $e',
      );

      debugPrint(
        stackTrace.toString(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
}

Future<bool> _enableLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  try {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

print('Location service enabled: $serviceEnabled');

permission = await Geolocator.checkPermission();

print('Permission: $permission');

  if (!serviceEnabled) {
    if (!kIsWeb) {
      await Geolocator.openLocationSettings();
    }
    return false;
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return false;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  vm.latitude = position.latitude;
  vm.longitude = position.longitude;

  try {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

  if (placemarks.isNotEmpty) {
    Placemark place = placemarks.first;

    print(place); // Debug: see available fields

    setState(() {
      vm.locationName =
          place.locality?.isNotEmpty == true
              ? '${place.locality}, ${place.administrativeArea}'
              : '${place.subAdministrativeArea ?? ""}, ${place.country ?? ""}';
    });
  }
} catch (e) {
  print('Geocoding error: $e');

  setState(() {
    vm.locationName =
        '${position.latitude.toStringAsFixed(4)}, '
        '${position.longitude.toStringAsFixed(4)}';
  });
}

  return true;
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            kIsWeb
                ? 'Location is blocked by the browser. Use HTTPS or localhost to allow location access.'
                : 'Unable to access location. Please enable location permission and try again.',
          ),
        ),
      );
    }

    return false;
  }

  
}

@override
  void dispose() {
    vm.dispose();
    super.dispose();
}

  //Progress Getter
  double get progressValue {
  if (vm.selectedRole != 'donor') {
    switch (vm.currentStep) {
      case 1:
        return 0.5;
      case 2:
        return 1.0;
      default:
        return 0.5;
    }
  }

  switch (vm.currentStep) {
    case 1:
      return 0.33;
    case 2:
      return 0.66;
    case 3:
      return 1.0;
    default:
      return 0.33;
  }
}

  Widget _buildStepContent(double screenWidth) {
    if (vm.currentStep == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: screenWidth > 900 ? 500 : screenWidth * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Join Vital Match',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your journey to saving lives starts with a few details.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              CustomTextField(
                label: 'Full Name',
                hintText: 'Full Name',
                controller: vm.fullNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              CustomTextField(
                label: 'Email Address',
                hintText: 'name@example.com',
                controller: vm.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              CustomTextField(
                label: 'Phone Number',
                hintText: '+237 670000000',
                controller: vm.phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

               CustomTextField(
                  label: 'Password',
                  hintText: '••••••••••',
                  obscureText: _obscurePassword,

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),

                  controller: vm.passwordController,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

              const SizedBox(height: 16),

                const Text(
                  'Account Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: vm.selectedRole,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: 'donor',
                      child: Text('Blood Donor'),
                    ),
                    DropdownMenuItem(
                      value: 'hospital_admin',
                      child: Text('Hospital Admin'),
                    ),
                    DropdownMenuItem(
                      value: 'blood_bank_manager',
                      child: Text('Blood Bank Manager'),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      vm.selectedRole = value!;
                    });
                  },
                ),
            ],
          ),
        ),
      );
    }

    if (vm.currentStep == 2 && vm.selectedRole == 'donor') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: screenWidth > 900 ? 500 : screenWidth * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medical Profile',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                'This helps us match you with urgent local needs.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              if(vm.selectedRole == 'donor') ...[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Blood Group',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          initialValue: vm.selectedBloodGroup,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a blood group';
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),

                          hint: const Text('Select'),

                          items: bloodGroups.map((group) {
                            return DropdownMenuItem(
                              value: group,
                              child: Text(group),
                            );
                          }).toList(),

                          onChanged: (value) {
                            setState(() {
                              vm.selectedBloodGroup = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: CustomTextField(
                      label: 'Weight (kg)',
                      hintText: '70',
                      controller: vm.weightController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Weight is required';
                        }

                        final weight = double.tryParse(value);

                        if (weight == null) {
                          return 'Enter a valid weight';
                        }

                        if (weight < 50) {
                          return 'Must be at least 50kg';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Date of Birth',
                hintText: 'DD/MM/YYYY',
                controller: vm.dateOfBirthController,
                readOnly: true,

                suffixIcon: const Icon(Icons.calendar_month),

                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    vm.dateOfBirthController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Date of birth is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,

                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: Colors.blue.shade100),
                ),

                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Donors must be at least 17 years old and weigh at least 50kg to be eligible for whole blood donation.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            ],
          ),
        ),
      );
    }

    if (vm.currentStep == 3) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: screenWidth > 900 ? 500 : screenWidth * 0.85,
          child: Column(
            children: [
              // Location Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFAF101A).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Color(0xFFAF101A),
                ),
              ),

              const SizedBox(height: 16),

                Row(
                  children: [
                    const Icon(
                      Icons.my_location,
                      color: Color(0xFFAF101A),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vm.locationName.isEmpty
                                ? 'Location not selected'
                                : vm.locationName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          if (vm.latitude != null && vm.longitude != null)
                            Text(
                              '${vm.latitude!.toStringAsFixed(4)}, '
                              '${vm.longitude!.toStringAsFixed(4)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              const Text(
                'Location Access',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'We use your location to find blood drives and hospitals near you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // Location Card
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: Column(
                  children: [
                    // Map Placeholder
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: vm.latitude != null &&
                        vm.longitude != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              vm.latitude!,
                              vm.longitude!,
                            ),
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.vitalmatch.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    vm.latitude!,
                                    vm.longitude!,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.map,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Enable Alerts',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Get notified of local emergencies',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        Switch(
                          value: vm.locationAlertsEnabled,
                          activeThumbColor: const Color(0xFFAF101A),

                          onChanged: (value) async {
                            if (value) {
                              bool success = await _enableLocation();

                              if (!mounted) return;

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Location enabled successfully'),
                                  ),
                                );

                                setState(() {
                                  vm.locationAlertsEnabled = true;
                                });
                              }
                            } else {
                              setState(() {
                                vm.locationAlertsEnabled = false;
                                  vm.latitude = null;
                                  vm.longitude = null;
                                  vm.locationName = '';
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Terms Checkbox
              CheckboxListTile(
                value: vm.agreedToTerms,

                activeColor: const Color(0xFFAF101A),

                contentPadding: EdgeInsets.zero,

                title: const Text(
                  'I agree to the Terms of Service and Privacy Policy',
                  style: TextStyle(fontSize: 14),
                ),

                onChanged: (value) {
                  setState(() {
                    vm.agreedToTerms = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Side
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),

                        const Text(
                          'Vital Match',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFAF101A),
                          ),
                        ),
                      ],
                    ),

                    // Right Side
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.help_outline),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Progress Indicator
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: SizedBox(
                  width: screenWidth > 900 ? 600 : screenWidth * 0.85,

                  child: Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              vm.selectedRole == 'donor'
                                ? 'Step ${vm.currentStep} of 3'
                                : 'Step ${vm.currentStep == 3 ? 2 : 1} of 2',
                              style: const TextStyle(color: Colors.grey),
                            ),

                            Text(
                              '${(progressValue * 100).round()}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFAF101A),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 8,
                            color: const Color(0xFFAF101A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Form(key: vm.formKey, child: _buildStepContent(screenWidth)),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: screenWidth > 900 ? 500 : screenWidth * 0.85,

                  child: Column(
                    children: [
                       ElevatedButton(
                        onPressed: () {

                          // Step 1 & 2 Validation
                          if (vm.currentStep == 1 || vm.currentStep == 2) {

                            if (!vm.formKey.currentState!.validate()) {
                              return;
                            }

                            setState(() {

                            // Skip medical profile for non-donors
                            if (
                              vm.currentStep == 1 &&
                              vm.selectedRole != 'donor'
                            ) {
                              vm.currentStep = 3;
                            } else {
                              vm.nextStep();
                            }

                          });
                            return;
                          }

                          // Step 3 Validation
                          if (vm.currentStep == 3) {

                            if (!vm.agreedToTerms) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please accept the Terms and Conditions',
                                  ),
                                ),
                              );

                              return;
                            }

                            if (vm.latitude == null || vm.longitude == null) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enable location to continue',
                                ),
                              ),
                            );

                            return;
                          }

                            _registerUser();

                            // Registration API call will come here
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAF101A),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vm.currentStep == 3
                                  ? 'Create Account'
                                  : 'Continue',
                            ),

                            const SizedBox(width: 8),

                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),

                      if (vm.currentStep > 1) ...[
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 56,

                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                vm.previousStep();
                              });
                            },

                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),

                            child: const Text('Back'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
