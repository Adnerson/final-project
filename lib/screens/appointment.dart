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
      body: Text(args.title),
    );
  }
}

class AppointmentArguments {
  String id;
  String appointmentDate;
  String title;
  String description;
  bool status;

  AppointmentArguments({
    required this.id,
    required this.appointmentDate,
    required this.title,
    required this.description,
    required this.status,
  });
}
