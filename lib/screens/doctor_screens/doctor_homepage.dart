import 'package:flutter/material.dart';
import 'package:project1/screens/doctor_screens/doctor_appointments.dart';
import 'package:project1/screens/doctor_screens/doctor_profile.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  MyDoctorPageState createState() => MyDoctorPageState();
}

class MyDoctorPageState extends State<DoctorHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const DoctorAppointmentScreen(),
    const DoctorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          ' MedAssist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class UserArguments {
  final int id;
  final String name;
  final String email;
  final String? address;
  final String? phoneNumber;

  UserArguments(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.phoneNumber});
}
