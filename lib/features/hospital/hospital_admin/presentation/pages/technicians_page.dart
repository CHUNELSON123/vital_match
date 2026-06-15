import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';
import '../widgets/create_technician_dialog.dart';
import '../viewmodels/technicians_viewmodel.dart';
import '../widgets/hospital_admin_sidebar.dart';
import '../widgets/hospital_admin_topbar.dart';
import '../widgets/technicians_table.dart';

class TechniciansPage extends StatefulWidget {
  final Hospital hospital;

  const TechniciansPage({
    super.key,
    required this.hospital,
  });

  @override
  State<TechniciansPage> createState() =>
      _TechniciansPageState();
}

class _TechniciansPageState
    extends State<TechniciansPage> {
  final vm = TechniciansViewModel();

  bool isLoading = true;

  List<LabTechnician> technicians = [];

  @override
  void initState() {
    super.initState();
    _loadTechnicians();
  }

  Future<void> _loadTechnicians() async {
    try {
      final result =
          await vm.getTechniciansByHospital(
        widget.hospital.hospitalId,
      );

      setState(() {
        technicians = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          HospitalAdminSidebar(
            selectedIndex: 1,
            hospital: widget.hospital,
          ),

          Expanded(
            child: Column(
              children: [
                HospitalAdminTopbar(
                  hospital: widget.hospital,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.all(24),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [
                            const Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  'Technicians',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text(
                                  'Manage hospital technicians',
                                ),
                              ],
                            ),

                            ElevatedButton.icon(
                              onPressed: () async {

                                final result =
                                    await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      const CreateTechnicianDialog(),
                                );

                                if (result == null) {
                                  return;
                                }

                                print(result);
                              },

                              icon: const Icon(
                                Icons.person_add,
                              ),

                              label: const Text(
                                'Create Technician',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        if (isLoading)
                          const Center(
                            child:
                                CircularProgressIndicator(),
                          )
                        else
                          TechniciansTable(
                            technicians:
                                technicians,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}