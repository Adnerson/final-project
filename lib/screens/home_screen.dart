import 'package:flutter/material.dart';
import 'package:project1/classes.dart';
import 'package:project1/user_provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController symptomController = TextEditingController();

  void getDiagnosis(String symptoms) async {
  try {
    const apiKey = '';
    const endpoint = 'https://api.openai.com/v1/...';
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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'How Can We Help?',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('test');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'View your schedule',
                style: TextStyle(color: Colors.white),
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
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter symptoms',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            /*Container(
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
            ),*/
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(color: Colors.black),
                  itemCount: user!.appointments.length,
                  itemBuilder: (context, index) {
                    Appointment currentAppointment = user.appointments[index];
                    return ListTile(
                      title: Text('${currentAppointment.title}: ${currentAppointment.getDate().toString().split(" ")[0]}'),
                      subtitle: Text('${currentAppointment.getDescription()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            userProvider.removeAppointment(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showNewAppointmentDialog(context, userProvider.addAppointment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Add Appointment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewAppointmentDialog(BuildContext context, Function(Appointment) addAppointment) {
    showDialog(
      context: context,
      builder: (context) {
        return NewAppointmentWidget(addAppointment: addAppointment);
      },
    );
  }
}

class NewAppointmentWidget extends StatefulWidget {
  final Function(Appointment) addAppointment;

  const NewAppointmentWidget({super.key, required this.addAppointment});

  @override
  NewAppointmentWidgetState createState() => NewAppointmentWidgetState();
}

class NewAppointmentWidgetState extends State<NewAppointmentWidget> {
  final TextEditingController TitleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('New Appointment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TitleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : ''),
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Select Date', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: DescriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  String title = TitleController.text;
                  String description = DescriptionController.text;
                  if (selectedDate != null) {
                    Appointment newAppointment = Appointment(title, selectedDate!, description);
                    widget.addAppointment(newAppointment);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please Enter a Date'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
