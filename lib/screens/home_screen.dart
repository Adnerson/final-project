import 'package:flutter/material.dart';
import 'package:project1/classes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            // Medications Container
            Container(
              height: 200, // Increased container height
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Changed border color to blue
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: ListView.separated( // Changed to ListView.separated to add Dividers
                  separatorBuilder: (context, index) => const Divider(color: Colors.black), // Added Divider
                  itemCount: medications.length,
                  itemBuilder: (context, index) {
                    Medication currentMedication = medications[index];
                    return ListTile(
                      title: Text(currentMedication.name),
                      subtitle: Text(
                        'Take ${currentMedication.getNumber()} pills at ${currentMedication.getTime()}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            medications.removeAt(index);
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
                _showNewMedicationDialog(context, _addMedication);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Change button background color to blue
              ),
              child: const Text(
                'Add Medication',
                style: TextStyle(color: Colors.white),
              ), // Set text color to white
            ),
            const SizedBox(height: 20), // Spacer
            // Appointments Container
            Container(
              height: 200, // Increased container height
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Changed border color to blue
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: ListView.separated( // Changed to ListView.separated to add Dividers
                  separatorBuilder: (context, index) => const Divider(color: Colors.black), // Added Divider
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    Appointment currentAppointment = appointments[index];
                    return ListTile(
                      title: Text(currentAppointment.doctorName),
                      subtitle: Text(
                        'Date: ${currentAppointment.getDate().toString().split(" ")[0]}, Time: ${currentAppointment.getTime()}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            appointments.removeAt(index);
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
                _showNewAppointmentDialog(context, _addAppointment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Change button background color to blue
              ),
              child: const Text(
                'Add Appointment',
                style: TextStyle(color: Colors.white),
              ), // Set text color to white
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog for adding new appointment
  void _showNewAppointmentDialog(BuildContext context, Function(Appointment) addAppointment) {
    showDialog(
      context: context,
      builder: (context) {
        return NewAppointmentWidget(addAppointment: addAppointment);
      },
    );
  }

  // Callback function to add appointment to the list
  void _addAppointment(Appointment newAppointment) {
    setState(() {
      appointments.add(newAppointment);
    });
  }

  // Function to show dialog for adding new medication
  void _showNewMedicationDialog(BuildContext context, Function(Medication) addMedication) {
  showDialog(
    context: context,
    builder: (context) {
      return NewMedicationWidget(addMedication: addMedication);
    },
  );
}

  // Callback function to add medication to the list
  void _addMedication(Medication newMedication) {
    setState(() {
      medications.add(newMedication);
    });
  }
}

class NewMedicationWidget extends StatefulWidget {
  final Function(Medication) addMedication;

  const NewMedicationWidget({super.key, required this.addMedication});

  @override
  NewMedicationWidgetState createState() => NewMedicationWidgetState();
}

class NewMedicationWidgetState extends State<NewMedicationWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Medication'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(labelText: 'Time'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Amount'),
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
                  backgroundColor: Colors.blue, // Change button background color to blue
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)), // Set text color to white
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String time = timeController.text;
                  int quantity = int.tryParse(quantityController.text) ?? 0;
                  Medication newMedication = Medication(name, time, quantity);
                  widget.addMedication(newMedication); // Call the callback to add the new medication
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button background color to blue
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)), // Set text color to white
              ),
            ],
          ),
        ],
      ),
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
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Appointment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: doctorController,
            decoration: const InputDecoration(labelText: 'Doctor Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(labelText: 'Time'),
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
                  backgroundColor: Colors.blue, // Change button background color to blue
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)), // Set text color to white
              ),
              ElevatedButton(
                onPressed: () {
                  String doctorName = doctorController.text;
                  DateTime date = DateTime.parse(dateController.text);
                  String time = timeController.text;
                  Appointment newAppointment = Appointment(doctorName, date, time);
                  widget.addAppointment(newAppointment); // Call the callback to add the new appointment
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button background color to blue
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)), // Set text color to white
              ),
            ],
          ),
        ],
      ),
    );
  }
}
