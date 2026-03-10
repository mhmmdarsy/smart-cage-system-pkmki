abstract class PetFeedService {
  Future<void> triggerFeedNow({required int deviceIndex});

  Future<void> setScheduleActive({
    required int scheduleIndex,
    required bool isActive,
  });

  Future<void> selectDevice({required int deviceIndex});

  Future<void> saveSchedule({
    required String name,
    required int hour,
    required int minute,
    required bool isActive,
  });
}
