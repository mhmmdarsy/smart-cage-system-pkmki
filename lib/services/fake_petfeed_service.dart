import 'dart:async';

import 'petfeed_service.dart';

class FakePetFeedService implements PetFeedService {
  static const _latency = Duration(milliseconds: 300);

  @override
  Future<void> triggerFeedNow({required int deviceIndex}) async {
    await Future<void>.delayed(_latency);
  }

  @override
  Future<void> setScheduleActive({
    required int scheduleIndex,
    required bool isActive,
  }) async {
    await Future<void>.delayed(_latency);
  }

  @override
  Future<void> selectDevice({required int deviceIndex}) async {
    await Future<void>.delayed(_latency);
  }

  @override
  Future<void> saveSchedule({
    required String name,
    required int hour,
    required int minute,
    required bool isActive,
  }) async {
    await Future<void>.delayed(_latency);
  }
}
