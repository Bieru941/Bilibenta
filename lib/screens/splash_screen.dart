import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storefront, size: 72),
            SizedBox(height: 16),
            Text(
              'BiliBenta',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Buy and sell with ease'),
          ],
        ),
      ),
    );
  }
}
