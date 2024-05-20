import 'package:flutter/material.dart';
import 'package:project1/classes.dart';
import 'package:intl/intl.dart';

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
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Add Medication',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
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

  void _addAppointment(Appointment newAppointment) {
    setState(() {
      appointments.add(newAppointment);
    });
  }

  void _showNewMedicationDialog(BuildContext context, Function(Medication) addMedication) {
  showDialog(
    context: context,
    builder: (context) {
      return NewMedicationWidget(addMedication: addMedication);
    },
  );
}

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
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String time = timeController.text;
                  int quantity = int.tryParse(quantityController.text) ?? 0;
                  Medication newMedication = Medication(name, time, quantity);
                  widget.addMedication(newMedication);
                  Navigator.of(context).pop();
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

class NewAppointmentWidget extends StatefulWidget {
  final Function(Appointment) addAppointment;

  const NewAppointmentWidget({super.key, required this.addAppointment});

  @override
  NewAppointmentWidgetState createState() => NewAppointmentWidgetState();
}

class NewAppointmentWidgetState extends State<NewAppointmentWidget> {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

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
            controller: doctorController,
            decoration: const InputDecoration(
              labelText: 'Doctor Name',
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
            controller: timeController,
            decoration: const InputDecoration(
              labelText: 'Time',
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
                  String doctorName = doctorController.text;
                  String time = timeController.text;
                  if (selectedDate != null) {
                    Appointment newAppointment = Appointment(doctorName, selectedDate!, time);
                    widget.addAppointment(newAppointment);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select a date.'),
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
