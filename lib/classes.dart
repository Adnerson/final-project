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

  Doctor(this.name, this.address, this.specialty, this.number);

  getName() => name;
  getAddress() => address;
  getSpecialty() => specialty;
  getNumber() => number;
}

List<Medication>medications = [];
List<Doctor>doctors = [];
List<Doctor>primaryDoctors = [];

