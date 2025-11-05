import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Enable biometrics and save user preference (called from Settings)
  static Future<bool>   enableBiometric(BuildContext context) async {
    try {
      final canCheck = await _auth.isDeviceSupported();
      if (!canCheck) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Biometric authentication not supported on this device")),
        // );
        return false;
      }

      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Scan your fingerprint to enable biometric unlock',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('biometric_enabled', true);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Biometric authentication enabled")),
        // );
        return true;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Authentication failed")),
        // );
        return false;
      }
    } catch (e) {
      debugPrint('Error during biometric enable: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

  /// Disable biometrics (called from Settings)
  static Future<void> disableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', false);
  }

  /// Check whether biometrics is enabled (for login check)
  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometric_enabled') ?? false;
  }

  /// Authenticate user when unlocking (called during app start or login)
  static Future<bool> authenticateUser(BuildContext context) async {
    try {
      final enabled = await isBiometricEnabled();
      if (!enabled) return false;

      final canCheck = await _auth.isDeviceSupported();
      if (!canCheck) return false;

      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Authenticate to unlock your app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      debugPrint('Error during authentication: $e');
      return false;
    }
  }
}
