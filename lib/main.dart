import 'package:flutter/material.dart';
import 'package:vital_match/features/auth/presentation/pages/onboarding_page_1.dart';
import 'package:vital_match/features/auth/presentation/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const VitalMatchApp());
}

class VitalMatchApp extends StatelessWidget {
  const VitalMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/onboarding': (context) => const OnboardingPage1(),
      },
      
      home: SplashPage(),
    );
  }
}
