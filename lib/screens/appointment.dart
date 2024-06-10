import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentState();

  static const routeName = '/appointment';
}

class _AppointmentState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AppointmentArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${args.id}'s Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              args.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              args.appointmentDate,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              args.description ?? 'error',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentArguments {
  String id;
  String appointmentDate;
  String title;
  String? description;
  bool status;

  AppointmentArguments({
    required this.id,
    required this.appointmentDate,
    required this.title,
    required this.description,
    required this.status,
  });
}
