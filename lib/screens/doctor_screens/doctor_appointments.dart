import 'package:flutter/material.dart';
import 'package:project1/services/func.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();

  static const routeName = '/home';
}

class HomeScreenState extends State<HomeScreen> with Func {

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
        ],
      ),
    ));
  }

  Padding greetUser(UserArguments args) {
    return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Hello ${args.name}! How can we help?',
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
}

class UserArguments {
  final int id;
  final String name;
  final String? address;
  final String? phoneNumber;

  UserArguments(
      {required this.id,
      required this.name,
      required this.address,
      required this.phoneNumber});
}
