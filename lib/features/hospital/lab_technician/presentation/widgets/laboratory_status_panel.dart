import 'package:flutter/material.dart';

class LaboratoryStatusPanel
    extends StatelessWidget {
  const LaboratoryStatusPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _serologyCard(),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _componentCard(),
        ),
      ],
    );
  }

  Widget _serologyCard() {
    return Container(
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
                Icons.science,
                color: Color(0xFF005FAF),
              ),
              SizedBox(width: 8),
              Text(
                'Serology Analysis',
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _row(
            'HIV Type I & II',
            'Negative',
            Colors.green,
          ),

          _row(
            'HBsAg',
            'Negative',
            Colors.green,
          ),

          _row(
            'HCV',
            'Processing...',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _componentCard() {
    return Container(
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
                Icons.bloodtype,
                color: Color(0xFF005FAF),
              ),
              SizedBox(width: 8),
              Text(
                'Component Split',
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _component(
            'Red Blood Cells',
            '320 ml',
            Colors.red,
          ),

          const SizedBox(height: 12),

          _component(
            'Plasma',
            '180 ml',
            Colors.blue,
          ),

          const SizedBox(height: 12),

          _component(
            'Platelets',
            '50 ml',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _component(
    String name,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(name),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),
          child: Text(amount),
        ),
      ],
    );
  }
}