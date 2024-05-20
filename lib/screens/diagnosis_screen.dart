import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  DiagnosisScreenState createState() => DiagnosisScreenState();
}

class DiagnosisScreenState extends State<DiagnosisScreen> {
  final TextEditingController symptomController = TextEditingController();
  String symptoms = '';
  String diagnosis = '';

  Future<void> getDiagnosis() async {
    const apiKey = 'YOUR_OPENAI_API_KEY';
    const endpoint = 'https://api.openai.com/v1/completions';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: '{"prompt": "$symptoms"}',
    );

    if (response.statusCode == 200) {
      setState(() {
        diagnosis = response.body;
      });
    } else {
      diagnosis = ('Failed to get diagnosis. Status code: ${response.statusCode}');
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
                  labelText: 'Enter how you\'re feeling',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  symptoms = symptomController.text;
                });
                getDiagnosis();
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
              child: Text(diagnosis),
            ),
          ],
        ),
      ),
    );
  }
}
