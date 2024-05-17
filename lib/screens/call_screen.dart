import 'package:flutter/material.dart';
import 'package:project1/classes.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  CallScreenState createState() => CallScreenState();
}

class CallScreenState extends State<CallScreen> {
  bool showPrimaryDoctors = false;
  bool hasInteracted = false;

  List<Doctor> getDisplayedDoctors() {
    return showPrimaryDoctors ? primaryDoctors : doctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contact a Doctor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showPrimaryDoctors = !showPrimaryDoctors;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                showPrimaryDoctors ? 'Show All Doctors' : 'Show Primary Doctors',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: getDisplayedDoctors().length,
                itemBuilder: (BuildContext context, int index) {
                  final doctor = getDisplayedDoctors()[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.getName(),
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(doctor.getSpecialty()),
                              Text(doctor.getNumber()),
                              Text(doctor.getAddress()),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            setState(() {
                              hasInteracted = true;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              hasInteracted = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              doctor.togglePrimary();
                              if (doctor.isPrimary) {
                                primaryDoctors.add(doctor);
                              } else {
                                primaryDoctors.remove(doctor);
                              }
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: doctor.isPrimary ? Colors.blue.withOpacity(0.8) : Colors.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(doctor.isPrimary ? Icons.remove : Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
