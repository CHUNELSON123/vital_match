import 'package:flutter/material.dart';

class LabTechnicianTopbar
    extends StatelessWidget {

  const LabTechnicianTopbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      decoration:
          const BoxDecoration(
        color: Colors.white,
      ),

      child: Row(
        children: [

          Expanded(
            child: TextField(
              decoration:
                  InputDecoration(
                hintText:
                    'Search...',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    const Color(
                  0xFFF5F5F5,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.notifications,
            ),
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.settings,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          const CircleAvatar(
            radius: 22,
            backgroundColor:
                Color(
              0xFFAF101A,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}