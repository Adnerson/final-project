import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({super.key});

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  final TextEditingController _title =
      TextEditingController(text: 'Scheduled visit');
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointment Info',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(210, 10, 10, 150),
              ),
            ),
            titleField(),
            descriptionField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                monthSelector(),
                TimeSelector(),
              ],
            ),
            // Expanded(
            //   child: Container(), // This takes up the remaining space
            // ),
            submitButton(),
          ],
        ),
      ),
    );
  }

  TextButton monthSelector() {
    return TextButton(
      // style: TextButton.styleFrom(
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.blue.withOpacity(0.75), // Text color
      // ),
      onPressed: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.4),
            ),
            child: const Icon(Icons.calendar_month_outlined),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'DATE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, size: 18)
                  ],
                ),
                //display date here
                Text('January 25'),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextButton TimeSelector() {
    return TextButton(
      // style: TextButton.styleFrom(
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.blue.withOpacity(0.75), // Text color
      // ),
      onPressed: () {},

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.4),
            ),
            child: const Icon(Icons.access_time_rounded),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'TIME',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, size: 18)
                  ],
                ),
                //display date here
                Text('10:00 AM'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container submitButton() {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.withOpacity(0.75), // Text color
        ),
        //this is where you implement ScheduleAppointment
        onPressed: () {},
        child: const Text(
          'Submit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container titleField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: _title,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue),
          // ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value in the field';
          }
          return null;
        },
      ),
    );
  }

  Container descriptionField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: _description,
        minLines: 12,
        maxLines: 12,
        decoration: InputDecoration(
          hintText: 'Description',
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue),
          // ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value in the field';
          }
          return null;
        },
      ),
    );
  }
}
