import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class Meta {
  final num currentPage;
  final num totalPage;
  final num totalRecord;
  final num pageSize;

  const Meta({
    required this.currentPage,
    required this.totalPage,
    required this.totalRecord,
    required this.pageSize,
  });

  factory Meta.empty() => const Meta(
        currentPage: 1,
        totalPage: 0,
        totalRecord: 0,
        pageSize: 10,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
