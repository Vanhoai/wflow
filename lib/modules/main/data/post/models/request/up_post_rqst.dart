class UpPostRequest {
  final String title;
  final String content;
  final String duration;
  final num salary;
  final String position;
  final num business;
  final List<num> categories;
  final List<num> tags;
  final List<String> tasks;

  UpPostRequest({
    required this.title,
    required this.content,
    required this.duration,
    required this.salary,
    required this.position,
    required this.business,
    required this.categories,
    required this.tags,
    required this.tasks,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'duration': duration,
      'salary': salary,
      'position': position,
      'business': business,
      'categories': categories,
      'tags': tags,
      'tasks': tasks,
    };
  }
}
