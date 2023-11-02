import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/task/models/create_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_model.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<TaskEntity, Failure>> addTaskToContract(CreateTaskModel model);
  Future<Either<TaskEntity, Failure>> updateTaskInContract(UpdateTaskModel model);
  Future<Either<String, Failure>> deleteTaskInContract(String id);
  Future<Either<List<TaskEntity>, Failure>> taskInContract(num id);
}
