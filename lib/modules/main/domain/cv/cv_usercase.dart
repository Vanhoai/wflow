import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';

abstract class CVUseCase {
  Future<List<CVEntity>> getMyCV();
}

class CVUseCaseImpl implements CVUseCase {
  final CVRepository cvRepository;

  CVUseCaseImpl({required this.cvRepository});

  @override
  Future<List<CVEntity>> getMyCV() async {
    return await cvRepository.getMyCV();
  }
}
