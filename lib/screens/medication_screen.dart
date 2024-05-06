import 'package:flutter/material.dart';
import 'package:project1/main.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  MedicationScreenState createState() => MedicationScreenState();
}

class MedicationScreenState extends State<MedicationScreen> {
  List<Medication> medications = []; // Initialize medications list

  @override
  void initState() {
    super.initState();
    medications = [];
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
            const Text('key: ,'),
            const SizedBox(height: 8),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                color: Colors.white, // Change the color as needed
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: ListView.builder(
                  itemCount: medications.length, // Check if medications is not null
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(medications[index].name), // Display medication name
                      subtitle: Text(
                          'Time to take: ${medications[index].getTime()}, Quantity: ${medications[index].getNumber()}'),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showNewMedicationDialog(context); // Call function to show dialog
              },
              child: Text('Add Medication'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog for adding new medication
  void _showNewMedicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return NewMedicationWidget();
      },
    );
  }
}

class NewMedicationWidget extends StatefulWidget {
  const NewMedicationWidget({Key? key}) : super(key: key);

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
          ElevatedButton(
            onPressed: () {
              // Validate input
              if (nameController.text.isNotEmpty &&
                  timeController.text.isNotEmpty &&
                  quantityController.text.isNotEmpty) {
                String name = nameController.text;
                String time = timeController.text;
                int quantity = int.tryParse(quantityController.text) ?? 0;

                Medication newMedication = Medication(name, time, quantity);

                MedicationScreenState screenState = context.findAncestorStateOfType<MedicationScreenState>()!;
                screenState.setState(() {
                  screenState.medications.add(newMedication);
                });
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
