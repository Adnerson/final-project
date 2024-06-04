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
            doctorsBuilder(context),
          ],
        ),
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
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(entryList[index]['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Text(
                        '${entryList[index]['specialization']}\n${entryList[index]['phoneNumber']}\n${entryList[index]['address']}'),
                    trailing: IconButton(
                      //ontap, i am trying to prompt the user into calling/getting directions
                      //however, I will probably have to create 2 map<int, String> of index and phoneNumber/address
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
}
