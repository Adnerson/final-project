import 'package:flutter/material.dart';
import 'package:project1/screens/diagnosis_screen.dart';
import 'package:project1/screens/call_screen.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97)
      ),
      routes: {
        '/diagnosis' : (context) => const DiagnosisScreen(),
        '/call' : (context) => const CallScreen(),
        '/home' : (context) => const MyHomePage(),
        '/login' : (context) => const LoginScreen(),
      },
      initialRoute: '/login'
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    const CallScreen(),
    const HomeScreen(),
    const DiagnosisScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('   MedAssist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
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
            icon: Icon(Icons.health_and_safety),
            label: 'Diagnosis',
          ),
        ],
      ),
    );
  }
}

