import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:project1/classes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Medication> medications = [];

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
            const Text('Welcome!'),
            const SizedBox(height: 8),
            Container(
              height: 150,
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
                child: ListView.builder(
                  itemCount: medications.length,
                  itemBuilder: (context, index) {
                    Medication currentMedication = medications[index];
                    return ListTile(
                      title: Text(currentMedication.name),
                      subtitle: Text(
                        'Take ${currentMedication.getNumber()} pills at ${currentMedication.getTime()}',
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
              child: Text('Add Medication'),
            ),
          ],
        ),
      ),
    );
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

  const NewMedicationWidget({Key? key, required this.addMedication}) : super(key: key);

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
                child: const Text('Cancel')
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
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
