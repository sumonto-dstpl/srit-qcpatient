import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef LocationCallback = void Function(Position? position, String? error);

class LocationPermissionHandler extends StatefulWidget {
  final LocationCallback onPermissionResult;

  // Optional button label
  final String buttonText;

  const LocationPermissionHandler({
    super.key,
    required this.onPermissionResult,
    this.buttonText = 'Get Location',
  });

  @override
  State<LocationPermissionHandler> createState() =>
      _LocationPermissionHandlerState();
}

class _LocationPermissionHandlerState extends State<LocationPermissionHandler> {
  bool _isLoading = false;

  Future<void> _handlePermissionAndGetLocation() async {
    setState(() {
      _isLoading = true;
    });

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
        });
        widget.onPermissionResult(null, 'Location permission denied by user.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
      });

      bool openSettings = await _showOpenSettingsDialog();
      if (openSettings) {
        await Geolocator.openAppSettings();
      }
      widget.onPermissionResult(
          null, 'Location permission permanently denied.');
      return;
    }

    // Permission granted, get location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _isLoading = false;
      });
      widget.onPermissionResult(position, null);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      widget.onPermissionResult(null, 'Failed to get location: $e');
    }
  }

  Future<bool> _showOpenSettingsDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission needed'),
            content: const Text(
                'Location permission is permanently denied. Please open settings to grant permission.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Open Settings'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePermissionAndGetLocation,
      child: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(widget.buttonText),
    );
  }
}
