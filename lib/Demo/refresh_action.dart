import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: YourScreen()));
}

class YourScreen extends StatefulWidget {
  const YourScreen({Key? key}) : super(key: key);

  @override
  State<YourScreen> createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  bool isRefreshing = false;

  Future<void> _onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      isRefreshing = false;
    });

    // Reload the screen by replacing it
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const YourScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Custom Refresh"),
        backgroundColor: Colors.deepPurple,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 60,
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        notificationPredicate: (_) => true,
        child: Stack(
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Pull down to refresh",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 800), // Dummy height for scroll
              ],
            ),

            // Custom refresh icon overlay (optional)
            if (isRefreshing)
              Positioned(
                top: 16,
                left: MediaQuery.of(context).size.width / 2 - 16,
                child: const Icon(
                  Icons.refresh,
                  size: 32,
                  color: Colors.deepPurple,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
