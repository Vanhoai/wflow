import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/task/models/create_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_status_model.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_repository.dart';

abstract class TaskUseCase {
  Future<Either<TaskEntity, Failure>> addTaskToContract(CreateTaskModel model);
  Future<Either<TaskEntity, Failure>> updateTaskInContract(UpdateTaskModel model);
  Future<Either<String, Failure>> deleteTaskInContract(String id);
  Future<Either<List<TaskEntity>, Failure>> taskInContract(num id);
  Future<Either<TaskEntity, Failure>> workerUpdateStatusTask(UpdateTaskStatusRequest request);
  Future<Either<TaskEntity, Failure>> businessUpdateStatusTask(UpdateTaskStatusRequest request);
}

class TaskUseCaseImpl implements TaskUseCase {
  final TaskRepository taskRepository;
  TaskUseCaseImpl({required this.taskRepository});

  @override
  Future<Either<TaskEntity, Failure>> addTaskToContract(CreateTaskModel model) async {
    return await taskRepository.addTaskToContract(model);
  }

  @override
  Future<Either<String, Failure>> deleteTaskInContract(String id) async {
    return await taskRepository.deleteTaskInContract(id);
  }

  @override
  Future<Either<TaskEntity, Failure>> updateTaskInContract(UpdateTaskModel model) {
    return taskRepository.updateTaskInContract(model);
  }

  @override
  Future<Either<List<TaskEntity>, Failure>> taskInContract(num id) {
    return taskRepository.taskInContract(id);
  }

  @override
  Future<Either<TaskEntity, Failure>> workerUpdateStatusTask(UpdateTaskStatusRequest request) async {
    return await taskRepository.workerUpdateStatusTask(request);
  }

  @override
  Future<Either<TaskEntity, Failure>> businessUpdateStatusTask(UpdateTaskStatusRequest request) async {
    return await taskRepository.businessUpdateStatusTask(request);
  }
}
