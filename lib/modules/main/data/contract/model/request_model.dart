class ApplyPostRequest {
  final num post;
  final num cv;

  ApplyPostRequest({required this.post, required this.cv});
  Map<String, dynamic> toJson() => {
        'post': post,
        'cv': cv,
      };
}

class GetCandidateApplied {
  final num page;
  final num pageSize;
  final String search;

  const GetCandidateApplied({
    required this.page,
    required this.pageSize,
    required this.search,
  });
}

class TaskCreateContractModel {
  final String title;
  final String content;
  final num startTime;
  final num endTime;

  const TaskCreateContractModel({
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });

  TaskCreateContractModel copyWith({
    String? title,
    String? content,
    num? startTime,
    num? endTime,
  }) {
    return TaskCreateContractModel(
      title: title ?? this.title,
      content: content ?? this.content,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'startTime': startTime,
        'endTime': endTime,
      };
}

class CreateContractModel {
  final num contract;
  final String title;
  final String content;
  final num salary;
  final List<TaskCreateContractModel> tasks;

  const CreateContractModel({
    required this.contract,
    required this.tasks,
    required this.title,
    required this.content,
    required this.salary,
  });

  Map<String, dynamic> toJson() => {
        'contract': contract,
        'tasks': tasks.map((e) => e.toJson()).toList(),
        'title': title,
        'content': content,
        'salary': salary,
      };
}
