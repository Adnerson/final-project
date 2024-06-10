import 'package:flutter/material.dart';
import 'package:project1/screens/appointment.dart';

class DoctorViewAppointment extends StatefulWidget {
  const DoctorViewAppointment({super.key});

  @override
  State<DoctorViewAppointment> createState() => _DoctorViewAppointmentState();

  static const routeName = '/doctorAppointment';
}

class _DoctorViewAppointmentState extends State<DoctorViewAppointment> {
  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as AppointmentArguments;

    return Scaffold(
      appBar: AppBar(
          // title: Text("${args.id}'s Appointment"),
          ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   args.title,
            //   style: const TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   args.appointmentDate,
            //   style: const TextStyle(fontSize: 12),
            // ),
            // Text(
            //   args.description ?? 'error',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}

// class DoctorAppointmentArguments {
//   String id;
//   String appointmentDate;
//   String title;
//   String description;
//   bool status;

//   DoctorAppointmentArguments({
//     required this.id,
//     required this.appointmentDate,
//     required this.title,
//     required this.description,
//     required this.status,
//   });
// }
