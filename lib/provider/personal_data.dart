import 'package:flutter/material.dart';

class PersonnalDataProvider extends ChangeNotifier {
  String? _password;
  String? _lastName;
  String? _firstName;
  String? _fatherName;
  String? _teoudatZeout;
  List<String>? _phoneNumber;
  String? _email;
  String? _address;
  List<String> selectedNames = [];

  String? get getEmail => _email;
  String? get getPassword => _password;
  String? get getLastName => _lastName;
  String? get getFirstName => _firstName;
  String? get getFatherName => _fatherName;
  String? get getTeoudatZeout => _teoudatZeout ?? 'Aucune';
  List<String>? get getPhoneNumber => _phoneNumber;
  String get getAddress => _address ?? "";

  saveRegisterPage1(String email, password) {
    _email = email;
    _password = password;
    notifyListeners();
  }

  saveFirstName(String firstName) {
    _firstName = firstName;
  }

  void addSelectedName(String name) {
    if (!selectedNames.contains(name)) {
      selectedNames.add(name);
      notifyListeners();
    }
  }

  void removeSelectedName(String name) {
    selectedNames.remove(name);
    notifyListeners();
  }
}
