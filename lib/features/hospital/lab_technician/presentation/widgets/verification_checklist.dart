import 'package:flutter/material.dart';

class VerificationChecklist extends StatelessWidget {
  const VerificationChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mandatory Verification Checklist',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'VERIFICATION IN PROGRESS',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _completedTile(
            title: 'Health Screening',
            description:
                'General physical exam, pulse, BP and medical questionnaire reviewed.',
          ),

          const SizedBox(height: 16),

          _completedTile(
            title: 'Blood Collected',
            description:
                '450ml successfully collected and labeled.',
          ),

          const SizedBox(height: 16),

          _pendingTile(),

          const SizedBox(height: 16),

          _lockedTile(),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {},
                style:
                    OutlinedButton.styleFrom(
                  foregroundColor:
                      const Color(
                    0xFFAF101A,
                  ),
                ),
                child: const Text(
                  'Reject Donation',
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: () {},
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green,
                ),
                child: const Text(
                  'Verify Donation',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _completedTile({
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor:
                Colors.green,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 16),

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
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendingTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor:
                Colors.red.shade100,
            child: const Icon(
              Icons.pending,
              color: Colors.red,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lab Testing',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Screening for HIV, Hepatitis B & C, Syphilis and Malaria.',
                ),

                const SizedBox(height: 12),

                LinearProgressIndicator(
                  value: .65,
                  backgroundColor:
                      Colors.grey.shade300,
                ),

                const SizedBox(height: 8),

                Text(
                  'Processing at Central Lab - Est completion 45 mins',
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.lock),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Donation Approval - Waiting for lab validation results.',
            ),
          ),
        ],
      ),
    );
  }
}