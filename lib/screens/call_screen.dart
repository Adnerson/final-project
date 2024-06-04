import 'package:flutter/material.dart';
import 'package:project1/classes.dart';
import 'package:project1/services/func.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  CallScreenState createState() => CallScreenState();
}

class CallScreenState extends State<CallScreen> with Func {
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
            switchDoctors(),
            const SizedBox(height: 8),
            // doctorDisplay(),
            doctorsBuilder(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton switchDoctors() {
    return ElevatedButton(
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
    );
  }

  Expanded doctorsBuilder(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: getDoctorsPostgresql(context),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true, //EXTREMELY IMPORTANT without this it won't work
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var entryList = snapshot.data!.toList();
                return Card(
                  child: ListTile(
                    title:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(entryList[index]['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Text('${entryList[index]['specialization']}\n${entryList[index]['phoneNumber']}\n${entryList[index]['address']}'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 30,
                      color: Colors.blue.withOpacity(0.9),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }

  Expanded doctorDisplay() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: getDisplayedDoctors().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('aaaa',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              subtitle: const Text('specialty\nnumber\naddress'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
                iconSize: 30,
                color: Colors.blue.withOpacity(0.9),
              ),
            ),
          );
        },
      ),
    );
  }

  Container containerDoctor(Doctor doctor) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // spreadRadius: 2,
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(doctor.getSpecialty()),
                Text(doctor.getNumber()),
                Text(doctor.getAddress()),
              ],
            ),
          ),

          // plusButton2(doctor),
        ],
      ),
    );
  }

  GestureDetector plusButton2(Doctor doctor) {
    return GestureDetector(
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
        child: Icon(doctor.isPrimary ? Icons.remove : Icons.add,
            color: Colors.white),
      ),
    );
  }
}
