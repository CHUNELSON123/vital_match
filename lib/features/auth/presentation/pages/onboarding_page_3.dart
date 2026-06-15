import 'package:flutter/material.dart';
import './welcome_page.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // Skip Button

              // Illustration
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: screenWidth > 900 ? 600 : screenWidth * 0.85,
                    height: 300,

                    child: Stack(
                      alignment: Alignment.center,

                      children: [

                        // Main Card
                        Container(
                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black12,
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              CircleAvatar(
                                radius: 28,
                                backgroundColor: const Color(0xFFAF101A),

                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                '12 Lives Saved',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFAF101A),
                                ),
                              ),

                              const SizedBox(height: 12),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),

                                child: const LinearProgressIndicator(
                                  value: 0.75,
                                  minHeight: 8,
                                  color: Color(0xFFAF101A),
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                '3 more to reach next milestone',
                              ),
                            ],
                          ),
                        ),

                        // Top Floating Badge
                        Positioned(
                          top: 10,
                          right: 0,

                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Icon(
                                    Icons.workspace_premium,
                                    color: Colors.amber,
                                  ),

                                  SizedBox(width: 5),

                                  Text('Gold Donor'),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              // Title
              const SizedBox(height: 24),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Track Your Impact',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // Description
              const SizedBox(height: 12),

                SizedBox(
                  width: screenWidth > 900 ? 500 : screenWidth * 0.8,
                  child: const Text(
                    'Earn rewards, monitor donations, and see the lives you help save.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),

              // Page Indicator
              const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 30,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAF101A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),

              // Get Started Button
              const SizedBox(height: 24),

                SizedBox(
                  width: screenWidth > 900 ? 500 : screenWidth * 0.85,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAF101A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Get Started'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}