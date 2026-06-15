import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class HospitalAdminTopbar extends StatelessWidget {
  final Hospital hospital;

  const HospitalAdminTopbar({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),

      child: Row(
        children: [

          Expanded(
            child: Text(
              hospital.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          Container(
            width: 280,
            height: 42,

            decoration: BoxDecoration(
              color: const Color(
                0xFFF5F5F5,
              ),

              borderRadius:
                  BorderRadius.circular(
                30,
              ),
            ),

            child: const TextField(
              decoration: InputDecoration(
                hintText:
                    'Search records...',
                prefixIcon:
                    Icon(Icons.search),
                border:
                    InputBorder.none,
              ),
            ),
          ),

          const SizedBox(width: 20),

          IconButton(
            onPressed: () {},

            icon: Stack(
              children: [

                const Icon(
                  Icons.notifications,
                  color:
                      Color(0xFF005DAC),
                ),

                Positioned(
                  right: 0,
                  top: 0,

                  child: Container(
                    width: 8,
                    height: 8,

                    decoration:
                        const BoxDecoration(
                      color: Colors.red,
                      shape:
                          BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.settings,
              color: Color(
                0xFF005DAC,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 18,
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}