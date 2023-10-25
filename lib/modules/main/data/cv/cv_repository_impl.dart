import 'package:wflow/modules/main/data/cv/cv_services.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';

class CVRepositoryImpl implements CVRepository {
  final CVService cvService;

  CVRepositoryImpl({required this.cvService});

  @override
  Future<List<CVEntity>> getMyCV() async {
    try {
      final cvs = await cvService.getMyCV();
      return cvs;
    } catch (exception) {
      return [];
    }
  }
}
