import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                color: Colors.blue, // Change the color as needed
              ),
              child: const Text(
                'Hello World',
                style: TextStyle(
                  color: Colors.white, // Change the text color as needed
                  fontSize: 18, // Change the font size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
