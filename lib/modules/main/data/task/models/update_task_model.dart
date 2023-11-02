class UpdateTaskModel {
  final num id;
  final String title;
  final String content;
  final num startTime;
  final num endTime;

  const UpdateTaskModel({
    required this.id,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'startTime': startTime,
        'endTime': endTime,
      };
}
