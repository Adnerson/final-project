import 'package:flutter/material.dart';
import 'classes.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final List<User> _users = []; // Store users

  User? get user => _user;

  void login(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void createUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  User? validateCredentials(String email, String password) {
    try {
      return _users.firstWhere((user) => user.email == email && user.password == password);
    } catch (e) {
      return null;
    }
  }

  void removeAppointment(int index) {
    if (index >= 0 && index < _user!.appointments.length) {
      _user?.appointments.removeAt(index);
      notifyListeners();
    }
  }

  void addAppointment(Appointment appointment) {
    _user?.appointments.add(appointment);
    notifyListeners();
  }

  void removeMedication(int index) {
    if (index >= 0 && index < _user!.medications.length) {
      _user?.medications.removeAt(index);
      notifyListeners();
    }
  }

  void addMedication(Medication medication) {
    _user?.medications.add(medication);
    notifyListeners();
  }

  void updateUserDetails(String name, String email, String password, String phoneNumber) {
    _user?.setName(name);
    _user?.setEmail(email);
    _user?.setPassword(password);
    _user?.setNumber(phoneNumber);
    notifyListeners();
  }
}

