import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/services/func.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({super.key});

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> with Func {
  final TextEditingController _title =
      TextEditingController(text: 'Scheduled visit');
  final TextEditingController _description = TextEditingController();
  final ValueNotifier<TimeOfDay> _selectedTimeNotifier =
      ValueNotifier(TimeOfDay(hour: 10, minute: 0));
  final ValueNotifier<DateTime> _selectedDateNotifier =
      ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;

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
                monthSelector(context, _selectedDateNotifier),
                TimeSelector(context, _selectedTimeNotifier),
              ],
            ),
            // Expanded(
            //   child: Container(), // This takes up the remaining space
            // ),
            submitButton(args),
          ],
        ),
      ),
    );
  }

  TextButton monthSelector(
      BuildContext context, ValueNotifier<DateTime> selectedDateNotifier) {
    Future<void> _selectDate() async {
      DateTime? newSelectedDate = await showDialog<DateTime>(
        context: context,
        builder: (context) {
          DateTime initialDate = selectedDateNotifier.value;
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 300,
              child: Center(
                child: SfDateRangePicker(
                  initialSelectedDate: initialDate,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is DateTime) {
                      Navigator.pop(context, args.value);
                    }
                  },
                ),
              ),
            ),
          );
        },
      );
      if (newSelectedDate != null) {
        selectedDateNotifier.value = newSelectedDate;
      }
    }

    return TextButton(
      onPressed: _selectDate,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ValueListenableBuilder<DateTime>(
              valueListenable: selectedDateNotifier,
              builder: (context, selectedDate, child) {
                String formattedDate =
                    DateFormat('MM/dd/yyyy').format(selectedDate);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'DATE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, size: 18),
                      ],
                    ),
                    Text(
                      formattedDate,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TextButton TimeSelector(
      BuildContext context, ValueNotifier<TimeOfDay> selectedTimeNotifier) {
    Future<void> _selectTime() async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTimeNotifier.value,
      );
      if (picked != null && picked != selectedTimeNotifier.value) {
        selectedTimeNotifier.value = picked;
      }
    }

    return TextButton(
      onPressed: _selectTime,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ValueListenableBuilder<TimeOfDay>(
              valueListenable: selectedTimeNotifier,
              builder: (context, selectedTime, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'TIME',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 18),
                      ],
                    ),
                    Text(
                      selectedTime.format(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container submitButton(int id) {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.withOpacity(0.75), // Text color
        ),
        //this is where you implement ScheduleAppointment
        onPressed: () {
          createAppointmentUsingPostgresql(
            id.toString(),
            combineDateTimeAndTimeOfDayToString(
                _selectedDateNotifier, _selectedTimeNotifier),
            _title.text,
            _description.text,
            false,
          );
          Navigator.pop(context);
          setState(() {});
        },
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

  String combineDateTimeAndTimeOfDayToString(
      ValueNotifier<DateTime> dateNotifier,
      ValueNotifier<TimeOfDay> timeNotifier) {
    final DateTime date = dateNotifier.value;
    final TimeOfDay time = timeNotifier.value;

    final DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    // Convert the combined DateTime to a string
    return combinedDateTime.toString();
  }
}
