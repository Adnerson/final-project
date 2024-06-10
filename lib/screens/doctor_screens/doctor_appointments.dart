import 'package:flutter/material.dart';
import 'package:project1/screens/appointment.dart';
import 'package:project1/screens/doctor_screens/doctor_view_appointment.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/services/func.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  DoctorAppointmentScreenState createState() => DoctorAppointmentScreenState();

  static const routeName = '/home';
}

class DoctorAppointmentScreenState extends State<DoctorAppointmentScreen>
    with Func {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          greetUser(args),
          upcomingVisitsText(),
          appointmentsBuilder(context),
        ],
      ),
    ));
  }

  Padding greetUser(UserArguments args) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Hello ${args.name}!',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
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

  FutureBuilder<List<dynamic>> appointmentsBuilder(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getAppointmentsPostgresql(context),
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
                      DoctorViewAppointment.routeName,
                      // argViewAppointmentDoctorViewAppointmentntArguments(
                      //   id: entryList[index]['id'].toString(),
                      //   appointmentDate: entryList[index]['appointmentdate'],
                      //   title: entryList[index]['title'],
                      //   description: entryList[index]['description'],
                      //   status: entryList[index]['status'],
                      // ),
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
}

// class UserArguments {
//   final int id;
//   final String name;
//   final String email;
//   final String? address;
//   final String? phoneNumber;

//   UserArguments(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.address,
//       required this.phoneNumber});
// }
