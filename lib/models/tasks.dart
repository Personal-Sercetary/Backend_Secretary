class TaskItem {
  final int? id;
  final String title;
  final String? description;
  final DateTime? executionDate;
  final int? duration;
  final bool taskProfesion;
  final String userId;

  TaskItem({
    this.id,
    required this.title,
    this.description,
    this.executionDate,
    this.duration,
    this.taskProfesion = false,
    required this.userId,
  });

  // Читаємо з БД
  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'] as int?,
      title: json['titel'] as String, // читаємо з твоєї колонки titel
      description: json['description'] as String?,
      executionDate: json['execution_date'] != null
          ? DateTime.parse(json['execution_date'] as String)
          : null,
      duration: json['duration'] as int?,
      taskProfesion: json['task_profesion'] as bool? ?? false,
      userId: json['user_id'] as String,
    );
  }

  // Записуємо в БД
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'titel': title,
      'description': description,
      if (executionDate != null)
        'execution_date': executionDate!.toIso8601String(),
      if (duration != null) 'duration': duration,
      'task_profesion': taskProfesion,
      'user_id': userId,
    };
  }
}
