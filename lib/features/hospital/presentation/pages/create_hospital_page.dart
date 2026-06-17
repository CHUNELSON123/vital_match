import 'package:flutter/material.dart';
import '../viewmodels/create_hospital_viewmodel.dart';
import '../../hospital_admin/presentation/pages/hospital_admin_dashboard.dart';

class CreateHospitalPage extends StatefulWidget {
  const CreateHospitalPage({super.key});

  @override
  State<CreateHospitalPage> createState() => _CreateHospitalPageState();
}

class _CreateHospitalPageState extends State<CreateHospitalPage> {
  final vm = CreateHospitalViewModel();

 @override
Widget build(BuildContext context) {
  final screenWidth =
      MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: Colors.white,

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text(
        'Create Hospital',
      ),
    ),

    body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth > 900
                ? 600
                : screenWidth * 0.85,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),

              child: Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color: const Color(
                      0xFFE0E0E0,
                    ),
                  ),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),

                child: Form(
                  key: vm.formKey,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Center(
                        child: Text(
                          'Hospital Information',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          'Register your hospital to begin managing donors and blood requests.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        'Hospital Name',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            vm.nameController,

                        decoration:
                            InputDecoration(
                          hintText:
                              'Regional Hospital Buea',

                          filled: true,

                          fillColor:
                              const Color(
                            0xFFF6F3F2,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            vm.addressController,

                        decoration:
                            InputDecoration(
                          hintText:
                              'Molyko, Buea',

                          filled: true,

                          fillColor:
                              const Color(
                            0xFFF6F3F2,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Contact Number',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            vm.contactController,

                        decoration:
                            InputDecoration(
                          hintText:
                              '670000000',

                          filled: true,

                          fillColor:
                              const Color(
                            0xFFF6F3F2,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: () async {
                            try {

                              await vm.createHospital();

                              if (!context.mounted) {
                                return;
                              }

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Hospital created successfully',
                                  ),
                                ),
                              );

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HospitalAdminDashboard(),
                                ),
                                (route) => false,
                              );

                            } catch (e) {

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          },

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xFFAF101A,
                            ),

                            foregroundColor:
                                Colors.white,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                30,
                              ),
                            ),
                          ),

                          child: const Text(
                            'Create Hospital',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

  @override
  void dispose() {

    vm.dispose();

    super.dispose();
  }
}
