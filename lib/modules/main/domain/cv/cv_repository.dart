import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

abstract class CVRepository {
  Future<List<CVEntity>> getMyCV();
}
