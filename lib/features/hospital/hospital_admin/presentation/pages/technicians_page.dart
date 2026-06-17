import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import '../widgets/create_technician_dialog.dart';
import '../viewmodels/technicians_viewmodel.dart';
import '../widgets/hospital_admin_sidebar.dart';
import '../widgets/hospital_admin_topbar.dart';
import '../widgets/technicians_table.dart';
import '../viewmodels/create_technician_viewmodel.dart';
import '../../data/models/technician_table_row.dart';
import '../viewmodels/delete_technician_viewmodel.dart';
import '../widgets/edit_technician_dialog.dart';
import '../viewmodels/update_technician_viewmodel.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

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
  int currentPage = 0;

  static const int pageSize = 10;
  bool isLoading = true;

  List<TechnicianTableRow> technicians = [];

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
        currentPage = 0;
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

    final paginatedTechnicians =
        technicians
            .skip(
              currentPage * pageSize,
            )
            .take(
              pageSize,
            )
            .toList();

    final hasNextPage =
        (currentPage + 1) * pageSize <
        technicians.length;
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

                                try {

                                  await CreateTechnicianViewModel()
                                    .createTechnician(
                                  fullName:
                                      result['fullName'],

                                  email:
                                      result['email'],

                                  phoneNumber:
                                      result['phoneNumber'],

                                  hospitalId:
                                      widget.hospital.hospitalId,

                                  employeeId:
                                      result['employeeId'],

                                  department:
                                      result['department'],
                                );

                                  await _loadTechnicians();

                                  if (mounted) {

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Technician created successfully',
                                        ),
                                      ),
                                    );
                                  }

                                } catch (e) {

                                  if (mounted) {

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.toString(),
                                        ),
                                      ),
                                    );
                                  }
                                }
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
                         Column(
                            children: [

                              TechniciansTable(
                                technicians:
                                    paginatedTechnicians,

                                onEdit: (
                                  technician,
                                ) async {

                                  final result =
                                      await showDialog(
                                    context: context,
                                    builder: (_) =>
                                        EditTechnicianDialog(
                                      technician: technician,
                                    ),
                                  );

                                  if (result == null) {
                                    return;
                                  }

                                  try {

                                    final updatedTechnician =
                                        LabTechnician(
                                      technicianId:
                                          technician
                                              .technician
                                              .technicianId,

                                      userId:
                                          technician
                                              .technician
                                              .userId,

                                      hospitalId:
                                          technician
                                              .technician
                                              .hospitalId,

                                      employeeId:
                                          result['employeeId'],

                                      department:
                                          result['department'],

                                      status:
                                          result['status'],

                                      fullName:
                                          result['fullName'],

                                      email:
                                          result['email'],

                                      phoneNumber:
                                          result['phoneNumber'],
                                    );

                                    await UpdateTechnicianViewModel()
                                        .updateTechnician(
                                      updatedTechnician,
                                    );

                                    await _loadTechnicians();

                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Technician updated successfully',
                                          ),
                                        ),
                                      );
                                    }

                                  } catch (e) {

                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },

                                 onDelete: (
                                  technician,
                                ) async {

                                  final confirmed =
                                      await showDialog<bool>(
                                    context: context,
                                    builder: (_) {

                                      return AlertDialog(
                                        title: const Text(
                                          'Delete Technician',
                                        ),

                                        content: Text(
                                          'Delete ${technician.user.fullName}?',
                                        ),

                                        actions: [

                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                false,
                                              );
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                true,
                                              );
                                            },
                                            child: const Text(
                                              'Delete',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirmed != true) {
                                    return;
                                  }

                                  try {

                                    await DeleteTechnicianViewModel()
                                        .deleteTechnician(
                                      technician
                                          .technician
                                          .technicianId,
                                    );

                                    await _loadTechnicians();

                                    if (mounted) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Technician deleted successfully',
                                          ),
                                        ),
                                      );
                                    }

                                  } catch (e) {

                                    if (mounted) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    'Showing ${paginatedTechnicians.length} of ${technicians.length} technicians',
                                  ),

                                  Row(
                                    children: [

                                      OutlinedButton(
                                        onPressed:
                                            currentPage > 0
                                                ? () {
                                                    setState(() {
                                                      currentPage--;
                                                    });
                                                  }
                                                : null,
                                        child: const Text(
                                          'Previous',
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      OutlinedButton(
                                        onPressed:
                                            hasNextPage
                                                ? () {
                                                    setState(() {
                                                      currentPage++;
                                                    });
                                                  }
                                                : null,
                                        child: const Text(
                                          'Next',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
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