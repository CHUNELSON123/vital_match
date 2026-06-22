import 'package:flutter/material.dart';

class VerificationDonorCard extends StatelessWidget {
  const VerificationDonorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Elena Rodriguez',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'ID: VML-88290',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Blood Group',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'O Positive',
                            style: TextStyle(
                              color: Color(0xFFAF101A),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Eligibility',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Eligible',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _infoRow(
                'Last Donation',
                '14 Feb 2024',
              ),

              _infoRow(
                'Weight',
                '68 kg',
              ),

              _infoRow(
                'Hemoglobin',
                '13.5 g/dL',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(
              0xFFF6F3F2,
            ),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Color(0xFF005FAF),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Recent Donor History',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _historyTile(
                'Platelet Donation',
                'Oct 12, 2023',
              ),

              const SizedBox(height: 10),

              _historyTile(
                'Whole Blood',
                'Jul 05, 2023',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyTile(
    String title,
    String date,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}