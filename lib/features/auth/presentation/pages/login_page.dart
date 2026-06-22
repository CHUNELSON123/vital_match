import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/donors/presentation/pages/donor_home_page.dart';
import 'package:vital_match/features/hospital/hospital_admin/presentation/pages/hospital_admin_dashboard.dart';
import 'package:vital_match/features/hospital/lab_technician/presentation/pages/lab_technician_dashboard.dart';
import 'package:vital_match/features/blood_bank/blood_bank_manager/presentation/pages/blood_bank_dashboard.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final loginUsecase = ServiceLocator.loginUsecase;

  Future<void> _loginUser() async {
  try {

    setState(() {
      _isLoading = true;
    });

    final user = await loginUsecase(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    print(
  'LOGIN ROLE => ${user.role}',
);

    switch (user.role) {
      case 'donor':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DonorHomePage(),
          ),
        );
        break;

      case 'hospital_admin':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HospitalAdminDashboard(),
          ),
        );
        break;

      case 'labTechnician':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LabTechnicianDashboard(),
          ),
        );
        break;

      case 'blood_bank_manager':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BloodBankDashboard(),
          ),
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unknown user role'),
          ),
        );
    }

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );

  } finally {

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Vital Match',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAF101A),
                        ),
                      ),
                    ),

                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.help_outline),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Centered Content
              Center(
                child: SizedBox(
                  width: screenWidth > 900 ? 500 : screenWidth * 0.85,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Continue saving lives today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),

                      const SizedBox(height: 40),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,

                              decoration: InputDecoration(
                                hintText: 'name@example.com',

                                prefixIcon: const Icon(
                                  Icons.mail_outline,
                                  color: Colors.grey,
                                ),

                                filled: true,
                                fillColor: const Color(0xFFF6F3F2),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF005FAF),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,

                              decoration: InputDecoration(
                                hintText: '••••••••',

                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),

                                filled: true,
                                fillColor: const Color(0xFFF6F3F2),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF005FAF),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color(0xFF005FAF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            SizedBox(
                              width: double.infinity,
                              height: 52,

                              child: ElevatedButton(
                                onPressed: _loginUser,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFAF101A),
                                  foregroundColor: Colors.white,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                                child: _isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(Icons.arrow_forward),
                                        ],
                                      ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                const Expanded(child: Divider()),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                const Expanded(child: Divider()),
                              ],
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              height: 52,

                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Illustration goes here
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
