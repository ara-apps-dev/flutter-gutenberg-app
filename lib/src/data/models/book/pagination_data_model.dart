import '../../../domain/entities/book/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required super.count,
    required super.next,
    required super.previous,
  });

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) =>
      PaginationMetaDataModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
      };
}
