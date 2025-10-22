import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/widget/user-answers.dart';

class UserOnboardingProvider extends ChangeNotifier {
  final UserAnswer _user = UserAnswer();
  int _currentStep = 0;

  UserAnswer get user => _user;

  void updateName(String? name) {
    _user.name = name;
    notifyListeners();
  }

  void updateAge(String? age) {
    _user.age = age != null && age.isNotEmpty ? int.tryParse(age) : null;
    notifyListeners();
  }

  void updateEmail(String? email) {
    _user.email = email;
    notifyListeners();
  }

  void updateGender(String? gender) {
    _user.gender = gender;
    notifyListeners();
  }

  void updateHeight(String? height) {
    _user.height =
    height != null && height.isNotEmpty ? double.tryParse(height) : null;
    notifyListeners();
  }

  void updateWeight(String? weight) {
    _user.weight =
    weight != null && weight.isNotEmpty ? double.tryParse(weight) : null;
    notifyListeners();
  }

  void updateTarget(String? target) {
    _user.target = target;
    notifyListeners();
  }

  void updateAvailableTime(String? time) {
    _user.availableTime = time;
    notifyListeners();
  }

  void updateActivityLevel(Map<String, dynamic>? level) {
    _user.activityLevel = level;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 4) {
      _currentStep++;
      notifyListeners();
    }
  }

  bool isCurrentStepValid() {
    switch (_currentStep) {
      case 0: // Name and Age
        return _user.name != null &&
            _user.name!.isNotEmpty &&
            _user.age != null &&
            _user.age! > 0;
      case 1:
        return _user.gender != null && _user.gender!.isNotEmpty;
      case 2:
        return _user.height != null && _user.weight! > 0;

      case 3:
        return _user.target != null;
      case 4:
        return _user.availableTime != null;
      case 5:
        return _user.activityLevel != null;
      default:
        return false;
    }
  }
}