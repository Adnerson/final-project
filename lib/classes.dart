class Medication {
  String name;
  String timeToTake;
  int number;

  Medication(this.name, this.timeToTake, this.number); 

  getName() {return name;}
  getTime() {return timeToTake;}
  getNumber() {return number;}
}

class Doctor {
  String name;
  String address;
  String specialty;
  String number;
  bool isPrimary = false;

  Doctor(this.name, this.address, this.specialty, this.number);
  void togglePrimary() {
    isPrimary = !isPrimary;
  }
  getName() => name;
  getAddress() => address;
  getSpecialty() => specialty;
  getNumber() => number;
}

class Appointment {
  String doctorName;
  DateTime date;
  String time;

  Appointment(this.doctorName, this.date, this.time);

  getDoctorName() => doctorName;
  getDate() => date;
  getTime() => time;
}


List<Medication>medications = [];
List<Appointment>appointments = [];
List<Doctor> doctors = [
  Doctor('Stephen Strange', '123 Main St', 'Pediatrician', '2939393939'),
  Doctor('John Doe', '456 Elm St', 'Cardiologist', '5555555555'),
  Doctor('Dolittle Dolittle', '789 Oak St', 'Veterinarian', '7777777777'),
  Doctor('Bruce Banner', '321 Pine St', 'General Practitioner', '1111111111'),
  Doctor('Sherlock Holmes', '654 Birch St', 'Family Medicine', '8888888888'),
  Doctor('Jane Smith', '987 Maple St', 'Dermatologist', '9999999999'),
  Doctor('Michael Jordan', '246 Walnut St', 'Orthopedic Surgeon', '2222222222'),
  Doctor('Emma Watson', '135 Cedar St', 'Ophthalmologist', '3333333333'),
];
List<Doctor> primaryDoctors = [];
String symptoms = '';
String diagnosis = '';