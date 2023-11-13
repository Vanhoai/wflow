import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

class CVSate extends Equatable {
  final bool isLoading;
  final List<CVEntity> cvEntities;
  final List<CVEntity> selectCvEntities;
  const CVSate({this.isLoading = false, required this.cvEntities, required this.selectCvEntities});

  CVSate copyWith({List<CVEntity>? cvEntities, bool? isLoading, List<CVEntity>? selectCvEntities}) {
    return CVSate(
        isLoading: isLoading ?? this.isLoading,
        cvEntities: cvEntities ?? this.cvEntities,
        selectCvEntities: selectCvEntities ?? this.selectCvEntities);
  }

  @override
  List<Object?> get props => [isLoading, cvEntities, selectCvEntities];
}
