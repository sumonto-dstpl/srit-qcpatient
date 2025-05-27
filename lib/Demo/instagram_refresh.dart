import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstaPullToRefreshPage(),
    );
  }
}

class InstaPullToRefreshPage extends StatefulWidget {
  const InstaPullToRefreshPage({super.key});

  @override
  State<InstaPullToRefreshPage> createState() => _InstaPullToRefreshPageState();
}

class _InstaPullToRefreshPageState extends State<InstaPullToRefreshPage>
    with SingleTickerProviderStateMixin {
  double _pullDistance = 0;
  bool _isRefreshing = false;
  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate refresh
    setState(() {
      _isRefreshing = false;
      _pullDistance = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Style Refresh'),
        backgroundColor: Colors.deepPurple,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is OverscrollNotification && !_isRefreshing) {
            setState(() {
              _pullDistance += notification.overscroll / 2;
              if (_pullDistance < 30 && !_isRefreshing) {
                _refreshData();
              }
            });
          }
          return false;
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${index + 1}'),
                );
              },
            ),

            // Custom refresh icon (centered, animated)
            // if (_pullDistance > 5 || _isRefreshing)
              Positioned(
                top: min(_pullDistance, 80),
                left: MediaQuery.of(context).size.width / 2 - 15,
                child: RotationTransition(
                  turns: _isRefreshing
                      ? _rotateController
                      : const AlwaysStoppedAnimation(0),
                  child: const Icon(
                    Icons.refresh,
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
