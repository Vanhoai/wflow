class CreateTaskModel {
  final num contract;
  final String title;
  final String content;
  final num startTime;
  final num endTime;

  const CreateTaskModel({
    required this.contract,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'contract': contract,
        'title': title,
        'content': content,
        'startTime': startTime,
        'endTime': endTime,
      };
}
