import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/task/models/create_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_model.dart';
import 'package:wflow/modules/main/data/task/task_service.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskService taskService;
  TaskRepositoryImpl({required this.taskService});

  @override
  Future<Either<TaskEntity, Failure>> addTaskToContract(CreateTaskModel model) async {
    try {
      final response = await taskService.addTaskToContract(model);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<String, Failure>> deleteTaskInContract(String id) async {
    try {
      final response = await taskService.deleteTaskInContract(id);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<TaskEntity, Failure>> updateTaskInContract(UpdateTaskModel model) async {
    try {
      final response = await taskService.updateTaskInContract(model);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<List<TaskEntity>, Failure>> taskInContract(num id) async {
    try {
      final response = await taskService.taskInContract(id);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }
}
