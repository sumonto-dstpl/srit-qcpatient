import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricTestScreen extends StatefulWidget {
  const BiometricTestScreen({super.key});

  @override
  State<BiometricTestScreen> createState() => _BiometricTestScreenState();
}

class _BiometricTestScreenState extends State<BiometricTestScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  String status = "Not Authenticated";

  Future<void> _authenticate() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (!canCheckBiometrics) {
      setState(() {
        status = "Device does not support biometrics";
      });
      return;
    }

    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      setState(() {
        status = authenticated ? "✅ Authenticated!" : "❌ Authentication Failed";
      });
    } catch (e) {
      setState(() {
        status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biometric Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text("Authenticate"),
            ),
          ],
        ),
      ),
    );
  }
}
