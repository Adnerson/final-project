import 'package:flutter/material.dart';
import 'package:project1/classes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  final TextEditingController symptomController = TextEditingController();

  Future<void> getDiagnosis(String symptoms) async {
    try {
      const apiKey = 'YOUR_OPENAI_API_KEY';
      const endpoint = 'https://api.openai.com/v1/...'; // Replace with the API endpoint

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'prompt': "As a medical assistant, I'm tasked with receiving symptoms from a user and providing potential causes, future steps, and the type of doctor to refer to. The symptoms I received are: $symptoms",
          'max_tokens': 150,
          'stop': ['\n'],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          diagnosis = jsonResponse['choices'][0]['text'].trim();
        });
      } else {
        setState(() {
          diagnosis = 'Failed to get diagnosis. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        diagnosis = 'Failed to get diagnosis. Please try again later.';
      });
    }
  }

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
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: const Text(
                'Intelligent-Nurse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: symptomController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter symptoms',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final symptoms = symptomController.text;
                getDiagnosis(symptoms);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.blue,
              ),
              child: const Text('Diagnose'),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Text(diagnosis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
