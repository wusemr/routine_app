class Routine {
  String? id;
  String? title;
  List<String>? days;
  DateTime? startTime;
  DateTime? endTime;
  bool? isCompleted;

  Routine({
    this.id,
    this.title,
    this.days,
    this.startTime,
    this.endTime,
    this.isCompleted = false,
  });

  Routine copyWith({
    String? id,
    String? title,
    List<String>? days,
    DateTime? startTime,
    DateTime? endTime,
    bool? isCompleted,
  }) {
    return Routine(
      id: id ?? this.id,
      title: title ?? this.title,
      days: days ?? this.days,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}