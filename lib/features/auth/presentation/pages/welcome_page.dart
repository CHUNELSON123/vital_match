import 'package:flutter/material.dart';
import 'package:vital_match/features/auth/presentation/pages/login_page.dart';
import './register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo section
              const SizedBox(height: 30),

              SizedBox(
                width: screenWidth > 900 ? 500 : screenWidth * 0.8,
                child: Image.asset(
                  'assets/images/vital_match_logo.png',
                  fit: BoxFit.contain,
                ),
              ),

              // Title
              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Every Donation Can Save Three Lives',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),

              // Description
              const SizedBox(height: 16),

              SizedBox(
                width: screenWidth > 900 ? 700 : screenWidth * 0.85,
                child: const Text(
                  'Connect with nearby hospitals, respond to emergency blood requests, track your impact, and help save lives in real time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),

              // Feature Cards
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _featureCard(
                      icon: Icons.emergency,
                      title: 'Emergency Alerts',
                      description:
                          'Real-time notifications for urgent blood needs near you.',
                    ),

                    _featureCard(
                      icon: Icons.favorite,
                      title: 'Life Impact Tracking',
                      description:
                          'See exactly how your donations help your local community.',
                    ),

                    _featureCard(
                      icon: Icons.campaign,
                      title: 'Community Campaigns',
                      description:
                          'Join local blood drives and community wellness events.',
                    ),
                  ],
                ),
              ),

              // Get Started Button
              const SizedBox(height: 30),

              SizedBox(
                width: screenWidth > 900 ? 500 : screenWidth * 0.85,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
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
                  child: const Text(
                    'Create an Account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // Sign In
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),

                  TextButton(
                    onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFFAF101A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 260,

      child: Card(
        elevation: 2,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFFAF101A), size: 32),

              const SizedBox(height: 12),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              Text(description, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
