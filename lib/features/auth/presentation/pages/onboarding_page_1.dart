import 'package:flutter/material.dart';
import 'package:vital_match/features/auth/presentation/pages/onboarding_page_2.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),

      body: SafeArea(
        child: SingleChildScrollView(

           child: Column(
        children: [

    // Skip button
    Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Skip'),
          ),
        ],
      ),
    ),

    // Illustration
   Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: SizedBox(
    width: screenWidth > 900 ? 500 : screenWidth * 0.8,
    height: screenWidth > 900 ? 250 : 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/vital_match_logo.png',
        fit: BoxFit.contain,
      ),
    ),
  ),
),
    const SizedBox(height: 24),

   Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Text(
    'Donate Blood. Save Lives.',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: screenWidth > 900 ? 36 : 28,
      fontWeight: FontWeight.bold,
    ),
  ),
),

  const SizedBox(height: 12),

// Description
    SizedBox(
      width: screenWidth > 900 ? 500 : screenWidth * 0.8,
      child: const Text(
        'Become part of a life-saving donor community.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ),

    const SizedBox(height: 30),

// Page Indicator
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Container(
      width: 30,
      height: 6,
      decoration: BoxDecoration(
        color: Color(0xFFAF101A),
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    const SizedBox(width: 8),

    Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    const SizedBox(width: 8),

    Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ],
),

const SizedBox(height: 24),

// Next Button
SizedBox(
  width: screenWidth > 900 ? 500 : screenWidth * 0.85,
  height: 56,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage2(),
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
        Text('Next'),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward),
      ],
    ),
  ),
),

  const SizedBox(height: 24),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Text(
    'Join thousands of heroes making a difference every single day through local blood centers.',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: screenWidth > 900 ? 14 : 12,
      color: Colors.grey.shade600,
    ),
  ),
),

//const SizedBox(height: 20),

  ],
),
      ),
        ),
       
    );
  }
}