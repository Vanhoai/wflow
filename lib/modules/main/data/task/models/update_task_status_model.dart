class UpdateTaskStatusRequest {
  final num id;
  final String status;

  UpdateTaskStatusRequest({required this.id, required this.status});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'status': status,
      };
}
