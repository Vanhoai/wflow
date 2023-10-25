import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

class SelectCVSate extends Equatable {
  final bool isLoading;
  final List<CVEntity> cvEntities;
  final num selectID;
  const SelectCVSate({this.isLoading = false, required this.cvEntities, required this.selectID});

  SelectCVSate copyWith({List<CVEntity>? cvEntities, bool? isLoading, num? selectID}) {
    return SelectCVSate(
        isLoading: isLoading ?? this.isLoading,
        cvEntities: cvEntities ?? this.cvEntities,
        selectID: selectID ?? this.selectID);
  }

  @override
  List<Object?> get props => [isLoading, cvEntities, selectID];
}
