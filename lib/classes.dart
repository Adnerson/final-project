class Medication {
  String name;
  String timeToTake;
  int number;

  Medication(this.name, this.timeToTake, this.number);

  String getName() => name;
  String getTime() => timeToTake;
  int getNumber() => number;
}

class User {
  static int _idCounter = 0;  // Static variable to keep track of the last id
  int userid;
  String name;
  String password;
  String email;
  bool isDoctor;
  String address;
  String number;
  List<Medication> medications = [];
  List<Appointment> appointments = [];

  User(this.name, this.password, this.email, this.isDoctor, this.address, this.number) : userid = _idCounter++;

  String getName() => name;
  String getPassword() => password;
  String getEmail() => email;
  String getAddress() => address;
  String getNumber() => number;
  setName(newName) => name = newName;
  setPassword(newPassword) => password = newPassword;
  setEmail(newEmail) => email = newEmail;
  setAddress(newAddress) => address = newAddress;
  setNumber(newNumber) => number = newNumber;
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

  String getName() => name;
  String getAddress() => address;
  String getSpecialty() => specialty;
  String getNumber() => number;
}

class Appointment {
  static int _idCounter = 0;  // Static variable to keep track of the last id
  int appointmentid;
  String title;
  DateTime date;
  String description;

  Appointment(this.title, this.date, this.description) : appointmentid = _idCounter++;

  int getAppointmentid() => appointmentid;
  String getTitle() => title;
  DateTime getDate() => date;
  String getDescription() => description;
}

List<Medication> medications = [];
List<Appointment> appointments = [];
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
