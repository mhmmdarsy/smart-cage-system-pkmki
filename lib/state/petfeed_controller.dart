import 'dart:async';

import 'package:flutter/foundation.dart';

import '../services/petfeed_service.dart';

class PetFeedController extends ChangeNotifier {
  PetFeedController({required PetFeedService service}) : _service = service;

  final PetFeedService _service;

  int _currentTab = 0;
  int _selectedDevice = 0;
  final List<bool> _scheduleActive = [true, false, false];

  int _editHour = 8;
  int _editMinute = 0;
  bool _editActive = true;
  String _editName = '';
  bool _isSaving = false;

  int get currentTab => _currentTab;
  int get selectedDevice => _selectedDevice;
  List<bool> get scheduleActive => List<bool>.unmodifiable(_scheduleActive);

  int get editHour => _editHour;
  int get editMinute => _editMinute;
  bool get editActive => _editActive;
  String get editName => _editName;
  bool get isSaving => _isSaving;

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  Future<void> triggerFeedNow() async {
    await _service.triggerFeedNow(deviceIndex: _selectedDevice);
  }

  void updateScheduleActive(int index, bool value) {
    _scheduleActive[index] = value;
    notifyListeners();
    unawaited(
      _service.setScheduleActive(scheduleIndex: index, isActive: value),
    );
  }

  void selectDevice(int index) {
    _selectedDevice = index;
    notifyListeners();
    unawaited(_service.selectDevice(deviceIndex: index));
  }

  void setEditName(String value) {
    _editName = value;
  }

  void incrementHour() {
    _editHour = (_editHour + 1) % 24;
    notifyListeners();
  }

  void incrementMinute() {
    _editMinute = (_editMinute + 5) % 60;
    notifyListeners();
  }

  void setEditActive(bool value) {
    _editActive = value;
    notifyListeners();
  }

  Future<void> saveSchedule() async {
    _isSaving = true;
    notifyListeners();
    try {
      await _service.saveSchedule(
        name: _editName,
        hour: _editHour,
        minute: _editMinute,
        isActive: _editActive,
      );
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
