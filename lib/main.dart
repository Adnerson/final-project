import 'package:flutter/material.dart';
import 'package:project1/screens/appointment.dart';
import 'package:project1/screens/doctor_screens/doctor_appointments.dart';
import 'package:project1/screens/doctor_screens/doctor_homepage.dart';
import 'package:project1/screens/doctor_screens/doctor_view_appointment.dart';
import 'package:project1/screens/schedule_appointment.dart';
import 'package:project1/user_provider.dart';
import 'package:provider/provider.dart';
import 'screens/user_screen.dart';
import 'screens/call_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      routes: {
        '/diagnosis': (context) => const UserScreen(),
        '/call': (context) => const CallScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        AppointmentScreen.routeName: (context) => const AppointmentScreen(),
        '/schedule_appointment': (context) => const ScheduleAppointment(),
        '/doctor': (context) => const DoctorHomePage(),
        DoctorViewAppointment.routeName: (context) =>
            const DoctorAppointmentScreen(),
      },
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    const CallScreen(),
    const HomeScreen(),
    const UserScreen(),
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
            icon: Icon(Icons.phone),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
