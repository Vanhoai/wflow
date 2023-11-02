import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/task/models/create_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_model.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

abstract class TaskService {
  Future<TaskEntity> addTaskToContract(CreateTaskModel model);
  Future<TaskEntity> updateTaskInContract(UpdateTaskModel model);
  Future<String> deleteTaskInContract(String id);
}

class TaskServiceImpl implements TaskService {
  final Agent agent;
  TaskServiceImpl({required this.agent});

  @override
  Future<TaskEntity> addTaskToContract(CreateTaskModel model) async {
    try {
      final response = await agent.dio.post('/task/add-task-to-contract', data: model.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return TaskEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> deleteTaskInContract(String id) async {
    try {
      final response = await agent.dio.delete('/task/delete-task-in-contract/$id');
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<TaskEntity> updateTaskInContract(UpdateTaskModel model) async {
    try {
      final response = await agent.dio.put('/task/update-task-in-contract', data: model.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return TaskEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
