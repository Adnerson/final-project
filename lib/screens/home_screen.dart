import 'package:flutter/material.dart';
import 'package:project1/classes.dart';
import 'package:project1/screens/appointment.dart';
import 'package:project1/services/func.dart';
import 'package:project1/user_provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();

  static const routeName = '/home';
}

class HomeScreenState extends State<HomeScreen> with Func {
  final TextEditingController symptomController = TextEditingController();
  String diagnosis = "";

  void getDiagnosis(String symptoms) async {
    try {
      const apiKey = 'YOUR_API_KEY_HERE'; // Replace with your actual API key
      const endpoint = 'https://api.openai.com/v1/engines/davinci/completions';
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'prompt':
              "As a medical assistant, I'm tasked with receiving symptoms from a user and providing potential causes, future steps, and the type of doctor to refer to. The symptoms I received are: $symptoms",
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
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          greetUser(args),
          scheduleAppointmentButton(args),
          diagnosisButton(),
          upcomingVisitsText(),
          appointmentsBuilder(context, args),
        ],
      ),
    ));
  }

  Padding greetUser(UserArguments args) {
    return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Hello ${args.name}! How can we help?',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
  }

  Card scheduleAppointmentButton(UserArguments args) {
    return Card(
            child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/schedule_appointment', arguments: args.id);
          },
          leading: const Icon(Icons.calendar_month),
          title: const Text(
            'Schedule a visit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text("Didn't eat your apple today?"),
          trailing: const Icon(Icons.arrow_right),
        ));
  }

  Card diagnosisButton() {
    return Card(
            child: ListTile(
          onTap: () {},
          leading: const Icon(Icons.health_and_safety),
          title: const Text(
            'DiagNOWsis™',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
              'Powered by a deep learning network specifically designed to diagnose patients.'),
          trailing: const Icon(Icons.arrow_right),
        ));
  }

  Padding upcomingVisitsText() {
    return const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Upcoming visits',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
  }

  FutureBuilder<List<dynamic>> appointmentsBuilder(
      BuildContext context, UserArguments args) {
    return FutureBuilder<List<dynamic>>(
      future: getAppointmentsById(context, args.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true, //EXTREMELY IMPORTANT without this it won't work
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var entryList = snapshot.data!.toList();
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppointmentScreen.routeName,
                      arguments: AppointmentArguments(
                        id: args.id.toString(),
                        appointmentDate: entryList[index]['appointmentdate'],
                        title: entryList[index]['title'],
                        description: entryList[index]['description'],
                        status: entryList[index]['status'],
                      ),
                    );
                  },
                  leading: const Icon(Icons.assignment_ind),
                  title: Text(entryList[index]['title']),
                  trailing: const Icon(Icons.arrow_right),
                ),
              );
            },
          );
        } else {
          return const Text("error");
        }
      },
    );
  }

  Scaffold scaffold1(
      User? user, UserProvider userProvider, BuildContext context) {
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
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.black),
                  itemCount: user!.appointments.length,
                  itemBuilder: (context, index) {
                    Appointment currentAppointment = user.appointments[index];
                    return ListTile(
                      title: Text(
                          '${currentAppointment.title}: ${currentAppointment.getDate().toString().split(" ")[0]}'),
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

  void _showNewAppointmentDialog(
      BuildContext context, Function(Appointment) addAppointment) {
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
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                  : 'Select Date',
              style: const TextStyle(color: Colors.white),
            ),
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
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  String title = TitleController.text;
                  String description = DescriptionController.text;
                  if (selectedDate != null) {
                    Appointment newAppointment = Appointment(
                      title,
                      selectedDate!,
                      description,
                    );
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
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserArguments {
  final int id;
  final String name;
  final String? address;
  final String? phoneNumber;

  UserArguments(
      {required this.id,
      required this.name,
      required this.address,
      required this.phoneNumber});
}
